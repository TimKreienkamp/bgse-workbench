# -*- coding: utf-8 -*-
"""
Created on Mon Dec  8 14:43:09 2014

@author: timkreienkamp
"""

# -*- coding: utf-8 -*-
"""
Created on Fri Dec  5 15:10:50 2014

@author: timkreienkamp
"""

import pandas

from xml.dom import minidom
xmldoc = minidom.parse('/users/timkreienkamp/documents/studium/data_science/computing_lab/project/project_data/stats.stackexchange.com/votes.xml')
itemlist = xmldoc.getElementsByTagName('row') 
#print len(itemlist)
print itemlist[0].attributes['Id'].value

attribute_list = ["Id","PostId","VoteTypeId","CreationDate","UserId", "BountyAmount"]


vote_frame = pandas.DataFrame(columns = attribute_list)

#iterate through every entry (tagged <row/>), look for each key in attribute_list for the corresponding value
for i in xrange(61169, len(itemlist)) :
        Id = itemlist[i].attributes[attribute_list[0]].value
        PostId = itemlist[i].attributes[attribute_list[1]].value
        #check for exeptions
        VoteTypeId = itemlist[i].attributes[attribute_list[2]].value
        CreationDate = itemlist[i].attributes[attribute_list[3]].value
        if attribute_list[4] in itemlist[i].attributes.keys():
            UserId = itemlist[i].attributes[attribute_list[4]].value
        else:
            UserId = ""
        if attribute_list[5] in itemlist[i].attributes.keys():
            BountyAmount = itemlist[i].attributes[attribute_list[5]].value
        else:
            BountyAmount = ""
        vote_frame.loc[i] = [Id, PostId, VoteTypeId, CreationDate, UserId, BountyAmount]
        print i


vote_frame["CreationDate"] = pandas.to_datetime(vote_frame["CreationDate"], dayfirst = True)

vote_frame.to_csv("votes.csv", index = False)
