# frozen_string_literal: true

module Avm
  module Launcher
    module Instances
      module Base
        class << self
          def extend_object(object)
            object.extend ::EacRubyUtils::SimpleCache
            object.extend ::EacRubyUtils::Speaker::Sender
            object.extend ::Avm::Launcher::Instances::Base::Cache
            object.extend ::Avm::Launcher::Instances::Base::Publishing
            super
          end

          def instanciate(path, parent)
            unless path.is_a?(::Avm::Launcher::Instances::Base)
              raise ::Avm::Launcher::Errors::NonProject, path unless path.project?

              path.extend(::Avm::Launcher::Instances::Base)
              path.parent = parent
            end
            path
          end
        end

        attr_accessor :parent

        # @return [Avm::Applications::Base]
        def application
          @application ||= ::Avm::Registry.applications.detect(project_name)
        end

        # @return [String, nil]
        def commit_id
          if parent.blank? && source.scm.respond_to?(:git_repo)
            source.scm.git_repo.rev_parse(options.git_current_revision)
          else
            source.scm.head_commit.id
          end
        rescue ::Avm::Registry::DetectionError
          nil
        end

        def name
          logical
        end

        def stereotype?(stereotype)
          stereotypes.include?(stereotype)
        end

        def to_parent_path
          return self unless @parent

          logical.gsub(/\A#{Regexp.quote(@parent.logical)}/, '')
        end

        def project?
          stereotypes.any?
        end

        def project_name
          ::File.basename(logical)
        end

        def included?
          ::Avm::Launcher::Context.current.settings.excluded_projects.exclude?(project_name)
        end

        # @return [Hash]
        def to_h
          super.to_h.merge(commit_id: commit_id, parent: parent&.logical)
        end

        private

        def options_uncached
          ::Avm::Launcher::Context.current.settings.instance_settings(self)
        end

        # @return [Avm::Sources::Base]
        def source_uncached
          ::Avm::Registry.sources.detect(real)
        end
      end
    end
  end
end
