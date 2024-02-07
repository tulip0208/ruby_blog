require 'rails_helper'
RSpec.describe 'users/index.html.erb', type: :feature do
  before(:each) do
    @author = User.create(name: 'Shahadat Hossain',
                          photo: 'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640',
                          bio: 'A skilled carpenter with over 15 years of experience, specializing ine.')
    @user = User.create(name: 'Rakibul Islam',
                        photo: 'https://images.unsplash.com/photo-1530268729831-4b0b9e170218?&fit=crop&w=640',
                        bio: 'A licensed therapist with expertise in cognitive-behavioral therapy and trauma-informed.')
    @post = Post.create(author: @author, title: 'First seed post', text: 'Lorem Ipsum is simple.')
    @post2 = Post.create(author: @author, title: 'Second seed post', text: 'Lorem Ipsum is simple2.')
    visit users_path
  end

  it 'should show users name' do
    expect(page).to have_content @author.name
    expect(page).to have_content @user.name       
  end

  it 'shows the profile picture of each user' do
    expect(page).to have_selector("img[src*='#{@author.photo}']")
    expect(page).to have_selector("img[src*='#{@user.photo}']")
  end

  it 'should show users posts_counter' do
    expect(page).to have_content @author.posts_counter
    expect(page).to have_content @user.posts_counter
  end

  it 'should redirects to that user page' do
    link = find("a[href='#{user_path(@user)}']")
    link.click
    expect(page).to have_current_path(user_path(@user))
  end
end
