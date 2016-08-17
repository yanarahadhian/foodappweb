desc "Erase and fill database"
task :clean_up_invitation => :environment do
  Invitation.delete_all
end