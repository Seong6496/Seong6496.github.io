#!/usr/bin/env ruby
#
# 영어 페이지에 페이지 단위 언어를 심는다.
#
# 배경: 사이트 기본값은 lang: ko-KR 이고 _layouts/default.html 이 그 값을
#       <html lang> 에 그대로 찍어서, 영어 글·/blog/en/ 목록까지 전부 ko-KR 로 나갔다.
#       영어 글은 front matter 에 lang: en / locale: en_US 를 이미 갖고 있지만
#       /blog/en/ 아래의 목록·허브 페이지는 없다.
#
# 규칙: front matter 에 lang 이 있으면 그대로 둔다.
#       없고 URL 이 /blog/en/ 으로 시작하면 lang: en, locale: en_US 를 심는다.
#       lang 이 en 인데 locale 이 없으면 locale: en_US (og:locale 용, jekyll-seo-tag 가 읽음).
#
# default.html 은 page.lang | default: site.lang 을 쓰므로 한국어 페이지는 그대로 ko-KR.

module MathSystem
  module PageLanguage
    EN_PREFIX = "/blog/en/".freeze

    def self.apply(page)
      data = page.data
      if data["lang"].to_s.empty? && page.url.to_s.start_with?(EN_PREFIX)
        data["lang"] = "en"
      end
      if data["lang"].to_s.start_with?("en") && data["locale"].to_s.empty?
        data["locale"] = "en_US"
      end
    end
  end
end

Jekyll::Hooks.register :site, :pre_render do |site|
  site.pages.each { |page| MathSystem::PageLanguage.apply(page) }

  site.collections.each_value do |collection|
    collection.docs.each { |doc| MathSystem::PageLanguage.apply(doc) }
  end
end
