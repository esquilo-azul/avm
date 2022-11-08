# frozen_string_literal: true

module Avm
  module Launcher
    module Instances
      module Base
        module Publishing
          def publish?(stereotype)
            return false unless stereotype.publish_class
            return false unless options.stereotype_publishable?(stereotype)

            filter = ::Avm::Launcher::Context.current.publish_options[:stereotype]
            filter.blank? ? true : filter == stereotype.name.demodulize
          end

          def publish_check
            stereotypes.each do |s|
              next unless publish?(s)

              puts "#{name.to_s.cyan}|#{s.label}|" \
                "#{s.publish_class.new(self).check}"
            end
          end

          def publish_run
            stereotypes.each do |s|
              next unless publish?(s)

              infov(name, "publishing #{s.label}")
              s.publish_class.new(self).run
            end
          end
        end
      end
    end
  end
end
