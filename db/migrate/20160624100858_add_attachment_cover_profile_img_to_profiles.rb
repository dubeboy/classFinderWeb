class AddAttachmentCoverProfileImgToProfiles < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.attachment :cover
      t.attachment :profile_img
    end
  end

  def self.down
    remove_attachment :profiles, :cover
    remove_attachment :profiles, :profile_img
  end
end
