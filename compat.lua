local names = {
    ["acacia"] = { "acaciatree", "stripped_acacia" },
    ["birch"] = { "birchtree", "stripped_birch" },
    ["cherry_blossom"] = { "cherrytree", "stripped_cherrytree" },
    ["crimson"] = { "crimson_hyphae", "stripped_crimson_hyphae" },
    ["dark_oak"] = { "darktree", "stripped_dark_oak" },
    ["jungle"] = { "jungletree", "stripped_jungle" },
    ["mangrove"] = { "mangrove_tree", "mangrove_stripped" },
    ["oak"] = { "tree", "stripped_oak" },
    ["spruce"] = { "sprucetree", "stripped_spruce" },
    ["warped"] = { "warped_hyphae", "stripped_warped_hyphae" }
}

for mcl, vl in pairs(names) do
    minetest.register_alias("vl_hollow_logs:"..vl[1].."_hollow", "mcl_trees:hollow_"..mcl)
    minetest.register_alias("vl_hollow_logs:"..vl[2].."_hollow", "mcl_trees:stripped_hollow_"..mcl)
end
