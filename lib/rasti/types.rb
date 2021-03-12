require 'multi_require'
require 'inflecto'
require 'rasti-enum'

module Rasti
  module Types

    extend MultiRequire

    require_relative 'types/castable'
    require_relative_pattern 'types/*'

  end
end