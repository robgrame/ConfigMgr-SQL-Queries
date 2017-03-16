-- Query semplificata per individuare i modelli e lo chassis type

declare @CollectionID as nvarchar(8) = 'SMSDM003' -- All Desktop and Server clients collection
declare @UserSIDs as nvarchar(256) = 'disabled'

select 
r.Name0 Computername,
cs.Manufacturer0 'Manufacturer',
(
 CASE 
 WHEN CS.Manufacturer0 IN ('LENOVO','IBM') THEN CSP.Version0
 ELSE CS.Model0
 END
 ) AS Model,

enc.ChassisTypes0,
csp.Version0
,CASE 
                  WHEN enc.chassistypes0 = 1 THEN 'Virtual' 
                  WHEN enc.chassistypes0 in (2,17,23) THEN 'Server' 
                  WHEN enc.chassistypes0 in (3,4,6,7,13,15,16,24)  THEN 'Desktop' 
                  WHEN enc.chassistypes0 in (8,9,10,11,12,14,18) THEN 'Notebook' 
  
                  ELSE 'Unknown' 
                END 
                AS [Chassis Type]
from fn_rbac_R_System (@UserSIDs) r
left join v_GS_COMPUTER_SYSTEM cs on cs.ResourceID = r.ResourceID
left join v_GS_COMPUTER_SYSTEM_PRODUCT csp on csp.ResourceID = r.ResourceID
left join v_gs_system_enclosure enc on enc.ResourceID = r.ResourceID
where r.ResourceID in (select fcm.resourceid from fn_rbac_FullCollectionMembership(@UserSIDs) fcm where fcm.CollectionID = @CollectionID)
