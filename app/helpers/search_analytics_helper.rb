module SearchAnalyticsHelper
  def latest_queries
    bar_chart(
      @latest_queries.group(:updated_at, :query).count,
      title: 'Latest Queries',
      xtitle: 'Number of times searched',
      library: {
        layout: { padding: { left: 100, right: 100, bottom: 20 } },
        ticks: { precision: 0 }
      }
    )
  end

  def top_queries
    bar_chart(
      @top_queries.group(:query).count.sort_by { |_, v| -v },
      title: 'Top Queries',
      xtitle: 'Number of times searched',
      library: {
        layout: { padding: { left: 100, right: 100, bottom: 20 } },
        ticks: { precision: 0 }
      }
    )
  end
end
