# -*- encoding : utf-8 -*-
module Douban
  class Client
    # @private
    module Utils
      private

      # Returns the configured user name or the user name of the authenticated user
      #
      # @return [String]
      def get_user_id
        @user_id ||= self.user.id
      end
    end
  end
end
