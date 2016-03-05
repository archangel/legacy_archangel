class RoleInput < SimpleForm::Inputs::CollectionSelectInput
  def multiple?
    false
  end

  def input_options
    super.tap do |options|
      options[:include_blank] = false
    end
  end

  def collection
    @collection ||= begin
      collection = []

      Archangel::ROLES.each do |role|
        collection << [I18n.t(:"archangel.roles.#{role}"), role]
      end

      collection
    end
  end
end
