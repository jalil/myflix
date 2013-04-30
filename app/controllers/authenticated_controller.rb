class AuthenticatedController < ApplicationController
  before_filter :require_sign_in
end
