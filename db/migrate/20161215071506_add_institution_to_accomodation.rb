class AddInstitutionToAccomodation < ActiveRecord::Migration[5.0]
  def change
    add_column :accommodations, :institution, :string
  end
end
