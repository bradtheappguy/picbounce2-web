# NOTE Could move this patch into config/environments/{test,development}.rb
#module Paperclip
#  module InstanceMethods #:nodoc:
#    def destroy_attached_files
#      Paperclip.log("NOT Deleting attachments.")
#    end
#  end
#end
#
#Paperclip::interpolates(:uuid) do |attachment, style|
#  attachment.instance.uuid
#end
