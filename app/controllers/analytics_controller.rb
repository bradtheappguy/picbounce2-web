require 'garb'
require 'nokogiri'
require 'mechanize'

class AnalyticsController < ApplicationController
  layout        :determine_layout
  before_filter :authorize
 
 
  def analytics
      send_file "app/views/analytics/clixtrAnalytics.swf", :disposition => 'inline', :type => "application/x-shockwave-flash"
  end
  
  def analyticsUniverse
      send_file "app/views/analytics/data/analyticsUniverse.xml", :disposition => 'inline'
  end
  
  def analyticsMetrics
      send_file "app/views/analytics/data/dataItemListForAnalytics.xml", :disposition => 'inline'
  end

  def viewer
    
  end
  def refreshFlurry
    FlurryRecord.import
    flash[:message] = "flurry has been refreshed"
    redirect_to '/admin'
  end
 
  def ga
    Garb::Session.login("clixtr.analytics@gmail.com", "qw12erty")
    profiles = Garb::Profile.all
    
    profile = nil
    for prof in profiles
      if prof.table_id == "ga:34002032"  
        profile = prof
      end  
    end
    if !params[:report]
      params[:report]="total"
    end
    
    report = Garb::Report.new(profile)
    report.dimensions :date
    report.sort :date
    if params[:report] == "total"
      metrics = [:visits, :visitors,:newVisits,:bounces]
    elsif params[:report] == "twitter"
      metrics = [:visits,:bounces]
      report.filters do
          contains(:referralPath, 'twitter')
      end
    elsif params[:report] == "facebook"
      metrics = [:visits,:bounces]
      report.filters do
          contains(:referralPath, 'facebook')
      end
    end
    report.metrics metrics
    results = report.results
    
    
    
    @ts = AnalyticsTimeSeries.new()
    @ts.points = []
    for res in results 
      point = {:date => res.date[0,4]+"-"+res.date[4,2]+"-"+res.date[6,2]
      }
      for metric in metrics
        point[metric] = res.send metric
      end 
      

      @ts.points << point
    end
    
    render :template => 'analytics/index' 
  end
  
  
  def inhouse
    if params[:report] == nil
      params[:report] = "all"
    end
    
    
    if params[:report] == "all"
    sql = "
      select 
        date_trunc('day', created_at) as date, 
        count(distinct facebook_access_token) + count(distinct case when facebook_access_token is not null then null else twitter_screen_name end) AS users,
        count(distinct facebook_access_token) AS facebook_access_token,
        count(distinct twitter_screen_name) AS twitter_screen_name,
        count(distinct facebook_access_token) *100. /nullif( count(distinct facebook_access_token) + count(distinct case when facebook_access_token is not null then null else twitter_screen_name end),0) AS percent_fb,
        count(distinct twitter_screen_name) *100. /nullif( count(distinct facebook_access_token) + count(distinct case when facebook_access_token is not null then null else twitter_screen_name end),0) AS percent_twitter,
       
        count(id) AS photos,
        sum(case when twitter_screen_name is null then 0 else 1 end) AS twitter_photos,
        sum(case when facebook_access_token is null then 0 else 1 end) AS facebook_photos,
        count(view_count) AS single_page_views,
        case when sum(view_count) is null then 0 else sum(view_count) end AS view_count,
        case when avg(view_count) is null then 0 else avg(view_count) end AS view_average,
        count(view_count) * 100. / nullif(sum(case when twitter_screen_name is null then 0 else 1 end),0) AS percent_visited_photos
        from photos group by  date_trunc('day', created_at)  order by date
    "
    
    
    
    columns = :users,
    :facebook_access_token,
    :twitter_screen_name,
    :percent_fb,
    :percent_twitter,
    :photos,
    :twitter_photos,
    :facebook_photos,
    :view_count,
    :view_average,
    :single_page_views,
    :percent_visited_photos
    
    
    elsif params[:report] = "cumulative"
    sql = "
      select 
        date_trunc('day', p1.created_at) as date, 
        count(distinct p2.facebook_access_token) + count(distinct case when p2.facebook_access_token is not null then null else p2.twitter_screen_name end) AS total_users,
        count(distinct p2.facebook_access_token) AS facebook_users,
        count(distinct p2.twitter_screen_name) AS twitter_users
        from (select distinct date_trunc('day', created_at) as created_at from photos) p1,
        photos p2
        where
        date_trunc('day', p2.created_at)<= p1.created_at
        group by  p1.created_at order by date
           
        
    "
    
    
    columns = :total_users,
    :facebook_users,
    :twitter_users 
    
    end
   
   
    
    @ts = AnalyticsTimeSeries.new()
    @ts.query = sql
    
    @ts.points = []
    Photo.find_by_sql(sql).each do |row|
       point = {:date => row.date}
       for col in columns
         point[col] = row.read_attribute(col)
       end
       
        @ts.points << point
    end 
    
    render :template => 'analytics/index' 

  end
  def query
    
    columns = params[:columns].split(",")
    
    
    @ts = AnalyticsTimeSeries.new()
    @ts.query = params[:sql]
    
    @ts.points = []
    Photo.find_by_sql(params[:sql]).each do |row|
       point = {params[:date_field] => row.read_attribute(params[:date_field])}
       for col in columns
         point[col] = row.read_attribute(col)
       end
       
        @ts.points << point
    end 
    
    render :template => 'analytics/index' 

  end
  
  
  
  def flurry
    sql = "
      select 
        a.date,
        a.sessions,
        a.new_users,
        a.retained_users,
        a.active_users,
        sum(b.new_users) as cumulative_users 
      from flurry_records a,
      flurry_records b 
      where b.date <= a.date
      group by a.date,
        a.sessions,
        a.new_users,
        a.retained_users,
        a.active_users
      order by a.date
    "
    
    @ts = AnalyticsTimeSeries.new()
    @ts.query = sql
    @ts.points = []
    
    Photo.find_by_sql(sql).each do |row|
       point = {:date => row.date, 
                :sessions => row.sessions,
                :new_users => row.new_users,
                :retained_users => row.retained_users,
                :active_users => row.active_users,
                :cumulative_users => row.cumulative_users,
                }
        @ts.points << point
    end 
    
    render :template => 'analytics/index' 
  end
  
  private 
  def determine_layout
    nil
  end
 
end
