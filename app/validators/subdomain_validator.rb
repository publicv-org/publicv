class SubdomainValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    return if value.blank?

    reserved_names = %w[aule aula bounces images ftp mail pop smtp admin user ssl sftp verify \
                        pec publicv tracking www zeroday corsidia]
    reserved_names = options[:reserved] if options[:reserved]
    object.errors[attribute] << I18n.t('errors.subdomain.reserved') if reserved_names.include?(value)
    check_subdomain_format(object.errors[attribute], value)
  end

  def check_subdomain_format(errors, value)
    errors << I18n.t('errors.subdomain.length') unless value.length.between?(3, 63)
    errors << I18n.t('errors.subdomain.dashes') unless value.match?(/^[^-].*[^-]$/i)
    errors << I18n.t('errors.subdomain.format') unless value.match?(/^[a-z0-9\-]*$/)
  end
end
