tinsert(ZGV.startups,function(self)
	if not ZGV.db.profile.load_gold then return end
	--ZGV.Gold.chores:AddChore{typ="daily",name="Daily A",income=12345,time=10,reqs={level=90}}
	--ZGV.Gold.chores:AddChore{typ="daily",name="Daily B",income=23234,time=12,reqs={level=50}}
	--ZGV.Gold.chores:AddChore{typ="daily",name="Daily C",income=14352,time=13,reqs={level=85}}
end)



local example_prices = {}
ZGV.Gold.data.example_prices = example_prices

example_prices[765]=002000
example_prices[2447]=003000
example_prices[79011]=021000
example_prices[79010]=024000
example_prices[72235]=018000
