# Try to convert a string to a boolean.
# Useful for Figaro because all values are string.
module StringToBoolean
  def to_bool
    !!(self == true || self.to_s.strip =~ (/^(true|t|yes|y|1)$/i))
  end
end

class Object
  include StringToBoolean
end

class TrueClass
  def to_bool
    return self
  end
end

class FalseClass
  def to_bool
    return self
  end
end
