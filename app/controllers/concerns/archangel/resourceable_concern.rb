module Archangel
  module ResourceableConcern
    extend ActiveSupport::Concern

    # TODO: Add authorization (optional)
    #       Add Ransack search (optional)
    #       Support nested resources
    #       Custom prefix for engines (config?)
    #       Option to return resource or resources in `location_after_create`
    #         and `location_after_update`

    included do
      attr_reader :resource_data

      before_action :set_resource_data, :load_resource

      helper_method :resources_path, :resources_url,
                    :resource_path, :resource_url,
                    :new_resource_path, :new_resource_url,
                    :edit_resource_path, :edit_resource_url
    end

    module ClassMethods
      def resourceful(options = {})
        @resource_data ||= {}
        @resource_data.merge!(options)
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

    def resources_path
      url_for_object(@resources)
    end

    def resources_url
      url_for_object(@resources, false)
    end

    def resource_path
      url_for_object(@resource)
    end

    def resource_url
      url_for_object(@resource, false)
    end

    def new_resource_path
      new_url_for_object(@resource)
    end

    def new_resource_url
      new_url_for_object(@resource, false)
    end

    def edit_resource_path
      edit_url_for_object(@resource)
    end

    def edit_resource_url
      edit_url_for_object(@resource, false)
    end

    protected

    def permitted_attributes
      []
    end

    def resource_params
      params.require(:"#{model_name}").permit(permitted_attributes)
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

    def load_resources_instance
      if resource_data[:paginate]
        page_param = params[resource_data[:page_param]]
        per_page = resource_data[:per_page]

        model_class.paginate(page: page_param,
                             per_page: per_page)
      else
        model_class.all
      end

      authorize @resources if resource_data[:authorize]
    end

    def load_new_resource_instance
      if action_name.to_sym == :new
        model_class.new
      else
        model_class.new(resource_params)
      end

      authorize @resource if resource_data[:authorize]
    end

    def load_member_resource_instance
      find_by_key = resource_data[:find_by]
      find_by_value = params[resource_data[:param_key]]

      model_class.find_by("#{find_by_key}": find_by_value)
    end

    private

    def load_resource
      if member_action?
        @resource ||= load_resource_instance

        set_instance_variable(model_name, @resource)
      else
        @resources ||= load_resources_instance

        set_instance_variable(controller_name, @resources)
      end
    end

    def load_resource_instance
      if new_actions.include?(action)
        load_new_resource_instance
      else
        load_member_resource_instance
      end
    end

    def action
      action_name.to_sym
    end

    def model_name
      controller_name.to_s.downcase.singularize
    end

    def model_class
      "Archangel::#{model_name.classify}".constantize
    end

    def set_instance_variable(object_name, object)
      instance_variable_set("@#{object_name}", object)
    end

    def url_for_object(object, only_path = true)
      polymorphic_url(object, only_path: only_path)
    end

    def new_url_for_object(object, only_path = true)
      new_polymorphic_url(object, only_path: only_path)
    end

    def member_action?
      !collection_actions.include?(action)
    end

    def collection_actions
      [:index]
    end

    def new_actions
      [:new, :create]
    end

    def set_resource_data
      @resource_data = {
        find_by: :id,
        param_key: :id,
        paginate: false,
        ransack: false,
        authorize: false,
        page_param: :page,
        per_page: 24
      }
    end
  end
end
