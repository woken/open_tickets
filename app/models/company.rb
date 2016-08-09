class Company < ActiveRecord::Base
  has_many :tickets

  validates :name, presence: true

  GIT_DIR = "repos/"

  def get_git
    working_dir = GIT_DIR + name
    system 'mkdir', '-p', GIT_DIR
    begin
      git = Git.open(working_dir, :log => Logger.new(STDOUT))
    rescue ArgumentError
      git = Git.clone(repository, name, :path => GIT_DIR)
    end
    return git
  end
end
