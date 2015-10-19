//
//  URLRequestString.h
//  tensWebProject
//
//  Created by tens on 15-10-7.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#ifndef tensWebProject_URLRequestString_h
#define tensWebProject_URLRequestString_h

#define TSAppKey     @"2679635439"
#define TSAppSecret  @"ade21bb8c3dee4c753d55843e6dd9f79"
#define TSBackcell   @"https://api.weibo.com/oauth2/default.html"
#define AccTokenRequest @"https://api.weibo.com/oauth2/access_token"

/*请求微博数据*/
#define TSWeiboUrl   @"https://api.weibo.com/2/statuses/friends_timeline.json"

/*请求微博评论数据*/
#define TSWeiBoDetailUrl @"https://api.weibo.com/2/comments/show.json"

/* 发送一条微博信息*/
#define TSendWeiboUrl @"https://api.weibo.com/2/statuses/update.json"

/*上传图片并发布一条新微博*/
#define TSendImageWeiboUrl @"https://upload.api.weibo.com/2/statuses/upload.json"

/* 获取关注好友列表*/
#define TSrequestUrl @"https://api.weibo.com/2/friendships/friends.json"




#endif
