module ActiveRecordExtension

  extend ActiveSupport::Concern

  module ClassMethods

    def search_columns(column_names)
      if column_names.any?
        define_singleton_method :search do |search_term|
          if search_term
            query_str = column_names.map { |name| "lower(#{name}) like lower(?)"}.join(' or ')
            query_args = ["%#{search_term}%"] * column_names.count
            where(query_str, *query_args)
          else
            scoped
          end
        end
      end
    end

  end

end

# include the extension 
ActiveRecord::Base.send(:include, ActiveRecordExtension)