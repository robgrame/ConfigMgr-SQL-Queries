select 
coll.CollectionID,
coll.SiteID,
coll.CollectionName
from fn_rbac_Collections(@UserSIDs) coll
where coll.CollectionType = 2
order by coll.CollectionName