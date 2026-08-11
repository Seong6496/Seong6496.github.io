#!/usr/bin/env ruby
#
# 자동 생성되는 아카이브 페이지(태그·카테고리·연도별 목록)를 검색 색인 대상에서 뺀다.
#
# 배경: 태그 아카이브가 sitemap 의 대부분을 차지해 크롤 예산을 먹고,
#       정작 본문 글이 "Discovered - currently not indexed" 로 밀려 있었다.
#
# 각 페이지에 두 값을 심는다.
#   noindex: true   -> _includes/head.html 이 <meta name="robots" content="noindex, follow"> 출력
#   sitemap: false  -> jekyll-sitemap 이 sitemap.xml 에서 제외 (lib/sitemap.xml 의 where_exp)
#
# 주의: robots.txt 로 크롤을 막으면 안 된다. Googlebot 이 페이지를 읽을 수 있어야
#       noindex 를 인식하고, follow 로 남긴 내부 링크를 타고 본문 글까지 간다.
#
# jekyll-archives 가 만드는 Archive 페이지는 front matter 파일이 없고
# Jekyll 의 `defaults` 도 먹지 않는다(Archive#initialize 가 data 의 default_proc 을
# 설정하지 않음). 그래서 렌더링 직전에 훅으로 직접 심는다.

module MathSystem
  module NoindexArchives
    # 이 layout 을 쓰는 페이지는 전부 noindex + sitemap 제외.
    #   tag / category   : jekyll-archives 가 만드는 개별 아카이브
    #   tags / categories / archives : _tabs/ 의 목록 허브 페이지
    LAYOUTS = %w(tag category tags categories archives).freeze

    def self.apply(page)
      return unless LAYOUTS.include?(page.data["layout"])

      page.data["noindex"] = true
      page.data["sitemap"] = false
    end
  end
end

# :site, :pre_render 는 모든 generator(jekyll-archives, jekyll-sitemap 포함) 가
# 끝난 뒤, 어떤 페이지도 렌더되기 전에 한 번 돈다.
Jekyll::Hooks.register :site, :pre_render do |site|
  site.pages.each { |page| MathSystem::NoindexArchives.apply(page) }

  site.collections.each_value do |collection|
    collection.docs.each { |doc| MathSystem::NoindexArchives.apply(doc) }
  end
end
