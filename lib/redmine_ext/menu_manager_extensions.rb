
require 'redmine/menu_manager'

module Redmine
  module MenuManager

    class MenuItem

      attr_reader :remote_options

      def initialize_with_remote(name, url, options)
        @remote_options = options.delete(:remote)
        initialize_without_remote(name, url, options)
      end

      alias_method :initialize_without_remote, :initialize
      alias_method :initialize, :initialize_with_remote

    end

    module MenuHelper

      def render_single_menu_node_with_remote(item, caption, url, is_sel)
        if remote_options = item.remote_options
          non_html_options = remote_options.kind_of?(Hash) ?
            remote_options.reverse_merge(:url => url) : { :url => url }
          link_to_remote(h(caption),
                         non_html_options,
                         item.html_options(:selected => is_sel))
        else
          render_single_menu_node_without_remote(item, caption, url, is_sel)
        end
      end

      alias_method :render_single_menu_node_without_remote, :render_single_menu_node
      alias_method :render_single_menu_node, :render_single_menu_node_with_remote

    end

  end
end

