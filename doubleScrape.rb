require 'mechanize'

linkArr = []

agent = Mechanize.new
page = agent.get('***')
page.links_with(:href => /\/***\/\d/).each do |link|
        linkArr.push(link.href)
end

puts linkArr

originalLinkArr = []

(0..linkArr.count-1).each do |i|
    page = agent.get(linkArr[i])
    page.links_with(:href => /***/).each do |link|
         originalLinkArr.push(link.href)
    end
    originalLinkArr = originalLinkArr.uniq
end

puts originalLinkArr

