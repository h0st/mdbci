task :run_unit do

  task :task_generator do |t| RakeTaskManager.new(t).run_unit end
  task :task_6819_show_box_info do |t| RakeTaskManager.new(t).run_unit end
  task :task_6755_show_platform_versions do |t| RakeTaskManager.new(t).run_unit end
  task :task_6844_ssh_pty_bug do |t| RakeTaskManager.new(t).run_unit end
  task :task_6754_bug do |t| RakeTaskManager.new(t).run_unit end
  task :task_6783_show_boxes do |t| RakeTaskManager.new(t).run_unit end
  task :task_6813_divide_show_boxes do |t| RakeTaskManager.new(t).run_unit end
  task :task_node_product do |t| RakeTaskManager.new(t).run_unit end
  task :task_boxes_manager do |t| RakeTaskManager.new(t).run_unit end
  task :task_repos_manager do |t| RakeTaskManager.new(t).run_unit end
  task :task_session do |t| RakeTaskManager.new(t).run_unit end
  task :task_6812_show_repo_manager_exceptions do |t| RakeTaskManager.new(t).run_unit end

  Rake::Task[:task_generator].execute
  Rake::Task[:task_6819_show_box_info].execute
  Rake::Task[:task_6755_show_platform_versions].execute
  Rake::Task[:task_6844_ssh_pty_bug].execute
  Rake::Task[:task_6754_bug].execute
  Rake::Task[:task_6813_divide_show_boxes].execute
  Rake::Task[:task_node_product].execute
  Rake::Task[:task_boxes_manager].execute
  Rake::Task[:task_repos_manager].execute
  Rake::Task[:task_session].execute
  Rake::Task[:task_6783_show_boxes].execute
  Rake::Task[:task_6812_show_repo_manager_exceptions].execute

  RakeTaskManager.get_failed_tests_info

end
