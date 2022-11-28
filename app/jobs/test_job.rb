class TestJob < ApplicationJob
  queue_as :urgent

  def perform(*args)
    # Do something later
    #get current route of the user
    redirect_to args[0]
    puts "------------------------------------------------------------------------------------------------BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB--------------------------------------------"
  end
end
