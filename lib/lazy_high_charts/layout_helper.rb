# coding: utf-8

module LazyHighCharts
  module LayoutHelper

    def high_chart(placeholder, object  , &block)
      object.html_options.merge!({:id=>placeholder})
      object.options[:chart][:renderTo] = placeholder

      hg = high_graph(placeholder,object , &block)

      unless ajax_enabled?(object)
        hg.concat(content_tag("div","", object.html_options))
      end
      hg
    end

    def high_stock(placeholder, object  , &block)
      object.html_options.merge!({:id=>placeholder})
      object.options[:chart][:renderTo] = placeholder

      hg = high_graph_stock(placeholder,object , &block)

      unless ajax_enabled?(object)
        hg.concat(content_tag("div","", object.html_options))
      end
      hg
    end

    def high_graph(placeholder, object, &block)
      build_html_output("Chart", placeholder, object, &block)
    end

    def high_graph_stock(placeholder, object, &block)
      build_html_output("StockChart", placeholder, object, &block)
    end

    def build_html_output(type, placeholder, object, &block)
      options_collection =  [ generate_json_from_hash(object.options) ]
      
      options_collection << %|"series": #{object.data.to_json}|

      graph =<<-EOJS
        var options, chart;
         options = { #{options_collection.join(',')} };
         #{capture(&block) if block_given?}
         chart = new Highcharts.#{type}(options);
      EOJS

      if ajax_enabled?(object)
        prepend = "(function() {"
        append  = "})()"
      else
        prepend =<<-EOJS
             <script type="text/javascript">
             (function() {
               var onload = window.onload;
               window.onload = function(){
                 if (typeof onload == "function") onload();
        EOJS

        append =<<-EOJS
               };
             })()
             </script>
         EOJS
      end
      graph.prepend(prepend)
      graph << append

      if defined?(raw)
        return raw(graph) 
      else
        return graph
      end

    end
    
    private

    def generate_json_from_hash hash
      hash.each_pair.map do |key, value|
        k = key.to_s.camelize.gsub!(/\b\w/) { $&.downcase }
        if value.is_a? Hash
          %|"#{k}": { #{generate_json_from_hash(value)} }|
        else
          if value.respond_to?(:js_code) && value.js_code?
            %|"#{k}": #{value}|
          else
            %|"#{k}": #{value.to_json}|
          end
        end
      end.flatten.join(',')
    end

    # If ajax is enabled then the <script> and <div> will not be created
    # @example chart = LazyHighCharts::HighChart.new('bar', :ajax_enabled => true)
    def ajax_enabled? object
      object.html_options[:ajax_enabled].present? && object.html_options[:ajax_enabled] == true
    end
    
  end
end
