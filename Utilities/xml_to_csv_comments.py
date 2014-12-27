# -*- coding: utf-8 -*-
"""
Created on Mon Dec  8 14:21:10 2014

@author: timkreienkamp
"""
from __future__ import division

import pandas

from xml.dom import minidom
xmldoc = minidom.parse('/users/timkreienkamp/documents/studium/data_science/computing_lab/project/project_data/stats.stackexchange.com/comments.xml')
itemlist = xmldoc.getElementsByTagName('row') 
#print len(itemlist)
print itemlist[0].attributes['Id'].value

attribute_list = ["Id","PostId","Score","Text","CreationDate","UserId","UserDisplayName"]


comment_frame = pandas.DataFrame(columns = attribute_list)

#iterate through every entry (tagged <row/>), look for each key in attribute_list for the corresponding value
for i in xrange(0, len(itemlist)) :
        Id = itemlist[i].attributes[attribute_list[0]].value
        PostId = itemlist[i].attributes[attribute_list[1]].value
        #check for exeptions
        if attribute_list[2] in itemlist[i].attributes.keys():
            Score = itemlist[i].attributes[attribute_list[2]].value
        else:
            Score = ""
        if attribute_list[3] in itemlist[i].attributes.keys():
            Text = itemlist[i].attributes[attribute_list[3]].value
        else:
            Text = ""
        CreationDate = itemlist[i].attributes[attribute_list[4]].value
        if attribute_list[5] in itemlist[i].attributes.keys():
            UserId = itemlist[i].attributes[attribute_list[5]].value
        else:
            UserId = ""
        if attribute_list[6] in itemlist[i].attributes.keys():
            UserDisplayName = itemlist[i].attributes[attribute_list[6]].value
        else:
            UserDisplayName = ""
        comment_frame.loc[i] = [Id,PostId,Score,Text,CreationDate,UserId,UserDisplayName]
        print str(i/len(itemlist)*100)+"%"

comment_frame.to_csv("comments.csv", index = False)

