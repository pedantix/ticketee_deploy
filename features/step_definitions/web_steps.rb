#require 'uri'
#require 'cgi'
#require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))


module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)



Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  first(:link, link).click
end

When(/^(?:|I )fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in(field, with: value)
end

When(/^(?:|I )press "([^"]*)"$/) do |button|
  click_button(button) 
end

When /^(?:|I )check "([^"]*)"$/ do |button|
  check(button)
end

When /^(?:I )attach the file "([^"]*)" to "([^"]*)"$/ do |path, field|
  attach_file(field, File.expand_path(path))
end


Then(/^(?:|I )should see "([^"]*)"$/) do |regexp|
    regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_xpath('//*', :text => regexp)
  else
    assert page.has_xpath?('//*', :text => regexp)
  end
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then(/^(?:|I )should see the title "(.*?)"$/) do |title|
  page.should have_title(title)
end



Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end

Then /^the "([^"]*)" field(?: within (.*))? should contain "([^"]*)"$/ do |field, parent, value|
  with_scope(parent) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should
      field_value.should =~ /#{value}/
    else
      assert_match(/#{value}/, field_value)
    end
  end
end

Then /^the "([^"]*)" field(?: within (.*))? should not contain "([^"]*)"$/ do |field, parent, value|
  with_scope(parent) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should_not
      field_value.should_not =~ /#{value}/
    else
      assert_no_match(/#{value}/, field_value)
    end
  end
end

Then /^I should see "(.*?)" within the tag "(.*?)" of "(.*?)"$/ do |text_value, tag, css_id|
   find("#{css_id}").find("#{tag}").should have_content(text_value)
end


Then(/^I should not see "(.*?)" within the tag "(.*?)" of "(.*?)"$/) do |text_value, tag, css_id|
   find("#{css_id}").find("#{tag}").should_not have_content(text_value)
end

Then(/^I should see link "(.*?)"$/) do |link|
  page.should have_link(link)
end


