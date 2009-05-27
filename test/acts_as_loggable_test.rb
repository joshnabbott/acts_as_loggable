require File.dirname(__FILE__) + '/test_helper'

class ActsAsLoggableTest < Test::Unit::TestCase
  fixtures :blog_posts, :products, :images, :users

  def setup
    User.current_user = users(:good_josh)
  end

  def test_user_should_be_present
    assert_not_nil User.current_user
  end

  def test_user_should_have_many_action_logs
    assert_not_nil User.current_user.action_logs
  end

  def test_action_log_should_be_for_create_action_on_create
    post = BlogPost.create(blog_posts(:post_one).attributes)
    assert_equal "Create", post.action_logs[0].action
  end

  def test_action_log_should_be_for_update_action_on_update
    post = BlogPost.update(1, { :title => "New Title" })
    assert_equal "Update", post.action_logs[0].action
  end

  def test_action_log_should_be_for_update_action_on_update
    post = BlogPost.destroy(1)
    assert_equal "Destroy", post.action_logs[0].action
  end

  def test_should_create_action_log_for_object_without_any_conditions_create_update_and_destroy
    post = BlogPost.create(blog_posts(:post_one).attributes)
    assert_equal 1, post.action_logs.size
    updated_post = BlogPost.update(1, { :title => "New Title" })
    assert_equal 1, updated_post.action_logs.size
    deleted_post = BlogPost.destroy(1)
    assert_equal 1, deleted_post.action_logs.size
  end

  def test_should_create_action_log_for_all_actions_not_in_except_actions
    image = Image.create(images(:picture_one).attributes)
    assert_equal 1, image.action_logs.size
    updated_image = Image.update(1, { :title => "New Title" })
    assert_equal 1, updated_image.action_logs.size
    deleted_image = Image.destroy(1)
    assert_equal 0, deleted_image.action_logs.size
  end

  def test_should_create_action_log_for_only_actions
    product = Product.create(products(:product_one).attributes)
    assert_equal 0, product.action_logs.size
    updated_product = Product.update(1, { :title => "New Title" })
    assert_equal 1, updated_product.action_logs.size
    deleted_product = Product.destroy(1)
    assert_equal 1, deleted_product.action_logs.size
  end
end