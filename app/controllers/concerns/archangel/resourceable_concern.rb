module Archangel
  module ResourceableConcern
    extend ActiveSupport::Concern

    included do
      include Archangel::ActionableConcern

      before_action :load_resource

      helper_method :resources_path, :resources_url,
                    :resource_path, :resource_url,
                    :new_resource_path, :new_resource_url,
                    :edit_resource_path, :edit_resource_url
    end

    module ClassMethods
      attr_reader :resource_opts

      private

      def resourceful(options = {})
        options.reject { |key, value| resource_option_keys.exclude?(key) }

        @resource_opts ||= {}
        @resource_opts.merge!(options)
      end

      def resource_option_keys
        [:find_by, :param_key, :paginate, :authorize, :page_param, :per_page]
      end
    end

    def index
      respond_with @resources
    end

    def show
      respond_with @resource
    end

    def new
      respond_with @resource
    end

    def create
      @resource.save

      respond_with @resource, location: location_after_create,
                              action: action_after_failed_create
    end

    def edit
      respond_with @resource
    end

    def update
      @resource.update(resource_params)

      respond_with @resource, location: location_after_update,
                              action: action_after_failed_update
    end

    def destroy
      @resource.destroy

      respond_with @resource, location: location_after_destroy
    end

    protected

    def permitted_attributes
      []
    end

    def model_name
      controller_name.to_s.downcase.singularize
    end

    def location_after_save
      url_for_object(model_class)
    end

    def location_after_create
      location_after_save
    end

    def location_after_update
      location_after_save
    end

    def location_after_destroy
      location_after_save
    end

    def action_after_failed_create
      :new
    end

    def action_after_failed_update
      :edit
    end

    def resources_path
      url_for_objects
    end

    def resources_url
      url_for_objects false
    end

    def resource_path(object = nil)
      url_for_object(object)
    end

    def resource_url(object = nil)
      url_for_object(object, false)
    end

    def new_resource_path
      new_url_for_object
    end

    def new_resource_url
      new_url_for_object false
    end

    def edit_resource_path(object = nil)
      edit_url_for_object(object)
    end

    def edit_resource_url(object = nil)
      edit_url_for_object(object, false)
    end

    private

    def resource_params
      params.require(:"#{model_name}").permit(permitted_attributes)
    end

    def load_resource
      set_resource_options

      if member_action?
        @resource ||= load_resource_instance

        set_instance_variable(model_name, @resource)

        authorize @resource if resource_data[:authorize]
      else
        @resources ||= load_resources_instance

        set_instance_variable(controller_name, @resources)

        authorize @resources if resource_data[:authorize]
      end
    end

    def load_resources_instance
      if resource_data[:paginate]
        page_param = params[resource_data[:page_param]]
        per_page = resource_data[:per_page]

        model_class.page(page_param).per(per_page)
      else
        model_class.all
      end
    end

    def load_resource_instance
      if new_actions.include?(action)
        load_new_resource_instance
      else
        load_member_resource_instance
      end
    end

    def load_new_resource_instance
      model_class.new
    end

    def load_member_resource_instance
      find_by_key = resource_data[:find_by]
      find_by_value = params[resource_data[:param_key]]

      model_class.find_by!("#{find_by_key}": find_by_value)
    end

    def set_instance_variable(object_name, object)
      instance_variable_set("@#{object_name}", object)
    end

    def model_class
      [
        self.class.name.split("::").first,
        model_name.classify
      ].join("::").constantize
    end

    def url_for_objects(only_path = true)
      polymorphic_url(resource_array + [controller_name], only_path: only_path)
    end

    def url_for_object(object = nil, only_path = true)
      object ||= @resource

      polymorphic_url(resource_array + [object], only_path: only_path)
    end

    def new_url_for_object(only_path = true)
      new_polymorphic_url(resource_array + [model_name], only_path: only_path)
    end

    def edit_url_for_object(object = nil, only_path = true)
      object ||= @resource

      edit_polymorphic_url(resource_array + [object], only_path: only_path)
    end

    def resource_array
      self.class.name.downcase.split("::").slice!(1..-2).map(&:to_sym)
    end

    def resource_data
      self.class.resource_opts
    end

    def set_resource_options
      self.class.resource_opts ||= {}
      self.class.resource_opts.reverse_merge!(find_by: :id,
                                              param_key: :id,
                                              paginate: true,
                                              authorize: true,
                                              page_param: :page,
                                              per_page: 24)
    end
  end
end
