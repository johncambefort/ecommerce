# frozen_string_literal: true

module ApiResponse
  class ErrorResponse < RuntimeError; end

  class InvalidParameter < ErrorResponse; end
  class ProductNilException < ErrorResponse; end
  class NotImplementedPromotion < ErrorResponse; end
end
