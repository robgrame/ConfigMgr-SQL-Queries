select distinct
r.name0 Computername,
os.Caption0 + ' ' + os.CSDVersion0 as OS,
isw.ARPDisplayName0 SoftwareName,
isw.ProductName0 ProductName,
isw.ProductVersion0 Version,
isw.InstalledLocation0,
isw.TimeStamp InventoryTimeStamp,
sic.TimeStamp ChangeTimeStamp,
isw.InstallDate0 InstallDate,
os.InstallDate0 OSInstallDate
from fn_rbac_SystemInventoryChanges(@UserSIDs) sic
left join v_GS_INSTALLED_SOFTWARE isw on isw.ResourceID = sic.ResourceID and isw.GroupID = isw.GroupID
left join v_R_System r on r.ResourceID = sic.ResourceID
left join v_GS_OPERATING_SYSTEM os on os.ResourceID = sic.ResourceID
where 
sic.TimeStamp > @StartDate
and isw.TimeStamp > @StartDate
and sic.ChangeType = 'I'
and sic.DisplayName = 'Installed Software'
and os.InstallDate0 < @StartDate
--and isw.InstallDate0 > @StartDate
and sic.ResourceID in ( select fcm.ResourceID from fn_rbac_FullCollectionMembership(@UserSIDs) fcm where fcm.CollectionID = @CollectionID)
order by isw.TimeStamp DESC