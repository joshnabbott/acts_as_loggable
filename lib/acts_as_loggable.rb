module ActiveRecord #:nodoc:
  module Acts #:nodoc:
    module Loggable #:nodoc:
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def acts_as_loggable(*conditions)
          has_many :action_logs, :as => :loggable, :order => 'action_logs.created_at desc'
          send :include, ActiveRecord::Acts::Loggable::InstanceMethods
          conditions = extract_conditions(conditions)
          do_logging(conditions)
        end

        private
          def do_logging(conditions)
            actions = set_actions(conditions)
            actions.each do |action|
              send("before_#{action}") { |record| record.log_action(:action => action.humanize) }
            end
          end

          def extract_conditions(*conditions)
            return if conditions.empty?
            conditions.flatten!
            conditions = conditions.respond_to?(:extract_options!) ? conditions.extract_options! : (conditions.last.is_a?(::Hash) ? conditions.pop : {}) # apparently rails v. 1.2.6 doesn't have the extract_options! method, so this little workaround does it
            conditions
          end

          def humanize(word)
            word.to_s.gsub(/_id$/, "").gsub(/_/, " ").capitalize
          end

          def set_actions(conditions)
            actions = %w( create update destroy )
            if conditions[:except]
              conditions[:except].each { |condition| actions.delete("#{condition}") }
            elsif conditions[:only]
              actions = conditions[:only].map(&:to_s)
            end
            return actions
          end
      end #ClassMethods

      module InstanceMethods
        def log_action(attributes = {})
          if User.current_user
            attributes.assert_valid_keys(:action, :description, :loggable_before_changes, :loggable_after_changes)
            attributes.merge!(:user => User.current_user)
            record = self.action_logs.build(attributes)
          end
        end
      end #InstanceMethods
    end #Loggable
  end #Acts
end #ActiveRecord
ActiveRecord::Base.send(:include, ActiveRecord::Acts::Loggable)