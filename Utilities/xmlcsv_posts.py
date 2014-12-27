# -*- coding: utf-8 -*-
"""
Created on Fri Dec  5 15:10:50 2014

@author: timkreienkamp
"""

import pandas

from xml.dom import minidom
xmldoc = minidom.parse('/users/timkreienkamp/documents/studium/data_science/computing_lab/project/project_data/stats.stackexchange.com/posts.xml')
itemlist = xmldoc.getElementsByTagName('row') 
#print len(itemlist)
print itemlist[0].attributes['Id'].value

attribute_list = ["Id","PostTypeId","AcceptedAnswerId","ParentId","CreationDate","Score","ViewCount","Body","OwnerUserId","OwnerDisplayName","LastEditorUserId","LastEditorDisplayName","LastEditDate","LastActivityDate","Title","Tags","AnswerCount","CommentCount","FavoriteCount","ClosedDate","CommunityOwnedDate"]


post_frame = pandas.DataFrame(columns = attribute_list)

#iterate through every entry (tagged <row/>), look for each key in attribute_list for the corresponding value
for i in xrange(0, len(itemlist)) :
        Id = itemlist[i].attributes[attribute_list[0]].value
        PostTypeId = itemlist[i].attributes[attribute_list[1]].value
        #check for exeptions
        if attribute_list[2] in itemlist[i].attributes.keys():
            AcceptedAnswerId = itemlist[i].attributes[attribute_list[2]].value
        else:
            AcceptedAnswerId = ""
        if attribute_list[3] in itemlist[i].attributes.keys():
            ParentId = itemlist[i].attributes[attribute_list[3]].value
        else:
            ParentId = ""
        CreationDate = itemlist[i].attributes[attribute_list[4]].value
        Score = itemlist[i].attributes[attribute_list[5]].value
        if attribute_list[6] in itemlist[i].attributes.keys():
            ViewCount = itemlist[i].attributes[attribute_list[6]].value
        else:
            ViewCount = 0
        Body = itemlist[i].attributes[attribute_list[7]].value
        if attribute_list[8] in itemlist[i].attributes.keys():
            OwnerUserId = itemlist[i].attributes[attribute_list[8]].value
        else:
            OwnerUserId = ""
        if attribute_list[9] in itemlist[i].attributes.keys():
            OwnerDisplayName = itemlist[i].attributes[attribute_list[9]].value
        else:
            OwnerDisplayName = ""
        if attribute_list[10] in itemlist[i].attributes.keys():
            LastEditorUserId = itemlist[i].attributes[attribute_list[10]].value
        else:
            LastEditorUserId = ""
        if attribute_list[11] in itemlist[i].attributes.keys():
            LastEditorDisplayName = itemlist[i].attributes[attribute_list[11]].value
        else:
            LastEditorDisplayName = ""
        if attribute_list[12] in itemlist[i].attributes.keys():
            LastEditDate = itemlist[i].attributes[attribute_list[12]].value
        else:
            LastEditDate = ""
        LastActivityDate = itemlist[i].attributes[attribute_list[13]].value
        if attribute_list[14] in itemlist[i].attributes.keys():
            Title =  itemlist[i].attributes[attribute_list[14]].value
        else:
            Title = ""
        if attribute_list[15] in itemlist[i].attributes.keys():
            Tags = itemlist[i].attributes[attribute_list[15]].value
        else:
            Tags = ""
        if attribute_list[16] in itemlist[i].attributes.keys():
            AnswerCount = itemlist[i].attributes[attribute_list[16]].value
        else:
            AnswerCount = 0
        if attribute_list[17] in itemlist[i].attributes.keys():
            CommentCount = itemlist[i].attributes[attribute_list[17]].value
        else:
            CommentCount = 0
        if attribute_list[18] in itemlist[i].attributes.keys():
            FavoriteCount = itemlist[i].attributes[attribute_list[18]].value
        else:
            FavoriteCount = 0
        if attribute_list[19] in itemlist[i].attributes.keys():
            ClosedDate = itemlist[i].attributes[attribute_list[19]].value
        else:
             ClosedDate = ""
        if attribute_list[20] in itemlist[i].attributes.keys():
            CommunityOwnedDate = itemlist[i].attributes[attribute_list[20]].value
        else:
            CommunityOwnedDate = ""
        post_frame.loc[i] = [Id,PostTypeId,AcceptedAnswerId,ParentId,CreationDate,Score,ViewCount,Body,OwnerUserId,OwnerDisplayName,LastEditorUserId,LastEditorDisplayName,LastEditDate,LastActivityDate,Title,Tags,AnswerCount,CommentCount,FavoriteCount,ClosedDate,CommunityOwnedDate]
        print i

post_frame.to_csv("posts_subsample.csv")
p
