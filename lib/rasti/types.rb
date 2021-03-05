require 'multi_require'

module Rasti
  module Types

    extend MultiRequire

    require_relative 'types/castable'
    require_relative_pattern 'types/*'

  end
end