class EmailValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)
    unless value =~ /\A([^@\.]|[^@\.]([^@\s\.]|(\.(?!\.))?)*[^@\.])@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/
      record.errors.add(attribute, :invalid, {:value => value}.merge!(options))
    end
  end
end
