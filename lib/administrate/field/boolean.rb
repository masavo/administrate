require_relative "base"

module Administrate
  module Field
    class Boolean < Base
      def to_s
        if data.nil?
          "-"
        else
          if options[:true] && options[:false]
            return data ? options[:true] : options[:false]
          end
          data.to_s
        end
      end
    end
  end
end
