module SoftDelete

  extend ActiveSupport::Concern

  module ClassMethods

    def has_soft_delete

      define_method :soft_delete! do
        self.deleted_at = Time.now
        logger.info "This is from info"
        self.save!
      end

      define_method :revive! do
        self.deleted_at = nil
        self.save!
      end

      default_scope { where(:deleted_at => nil) }

    end
    
  end

end

# include the extension 
ActiveRecord::Base.send(:include, SoftDelete)