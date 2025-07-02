return {
        ['testburger'] = {
                label = 'Test Burger',
                weight = 220,
                metadata = { quality = 'Common' },
                degrade = 60,
                client = {
                        image = 'burger_chicken.png',
                        status = { hunger = 200000 },
                        anim = 'eating',
                        prop = 'burger',
                        usetime = 2500,
                        export = 'ox_inventory_examples.testburger',
                        notification = 'You consumed a test burger'
                },
		server = {
			export = 'ox_inventory_examples.testburger',
			test = 'what an amazingly delicious burger, amirite?'
		},
		buttons = {
			{
				label = 'Lick it',
				action = function(slot)
					print('You licked the burger')
				end
			},
			{
				label = 'Squeeze it',
				action = function(slot)
					print('You squeezed the burger :(')
				end
			},
			{
				label = 'What do you call a vegan burger?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('A misteak.')
				end
			},
			{
				label = 'What do frogs like to eat with their hamburgers?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('French flies.')
				end
			},
			{
				label = 'Why were the burger and fries running?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('Because they\'re fast food.')
				end
			}
		},
		consume = 0.3
	},

        ['bandage'] = {
                label = 'Bandage',
                weight = 115,
                metadata = { quality = 'Common' },
                client = {
                        anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
                        prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
                        disable = { move = true, car = true, combat = true },
                        usetime = 2500,
                        notification = 'You applied a bandage'
                }
        },

        ['black_money'] = {
                label = 'Dirty Money',
                metadata = { quality = 'Rare' },
                client = {
                        notification = 'You inspected your dirty money'
                }
        },

        ['burger'] = {
                label = 'Burger',
                weight = 220,
                metadata = { quality = 'Common' },
                client = {
                        status = { hunger = 200000 },
                        anim = 'eating',
                        prop = 'burger',
                        usetime = 2500,
			notification = 'You ate a delicious burger'
		},
	},

        ['sprunk'] = {
                label = 'Sprunk',
                weight = 350,
                metadata = { quality = 'Common' },
                client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_can_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with a sprunk'
		}
	},

        ['parachute'] = {
                label = 'Parachute',
                weight = 8000,
                metadata = { quality = 'Uncommon' },
                stack = false,
                client = {
                        anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
                        usetime = 1500,
                        notification = 'You used a parachute'
                }
        },

        ['garbage'] = {
                label = 'Garbage',
                metadata = { quality = 'Common' },
                client = {
                        notification = 'You looked through the garbage'
                }
        },

        ['paperbag'] = {
                label = 'Paper Bag',
                weight = 1,
                metadata = { quality = 'Common' },
                stack = false,
                close = false,
                consume = 0,
                client = {
                        notification = 'You used a paper bag'
                }
        },

        ['identification'] = {
                label = 'Identification',
                metadata = { quality = 'Uncommon' },
                client = {
                        image = 'card_id.png',
                        notification = 'You checked your identification'
                }
        },

        ['panties'] = {
                label = 'Knickers',
                weight = 10,
                metadata = { quality = 'Uncommon' },
                consume = 0,
                client = {
			status = { thirst = -100000, stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
                        usetime = 2500,
                        notification = 'You smelled the knickers',
                }
        },

        ['lockpick'] = {
                label = 'Lockpick',
                weight = 160,
                metadata = { quality = 'Uncommon' },
                client = {
                        notification = 'You used a lockpick'
                }
        },

	['phone'] = {
		label = 'Phone',
		weight = 190,
		stack = false,
		consume = 0,
		metadata = { quality = 'Common' },
		client = {
			add = function(total)
				if total > 0 then
					pcall(function() return exports.npwd:setPhoneDisabled(false) end)
				end
			end,

                        remove = function(total)
                                if total < 1 then
                                        pcall(function() return exports.npwd:setPhoneDisabled(true) end)
                                end
                        end,
                        notification = 'You used your phone'
                }
        },

        ['money'] = {
                label = 'Money',
                metadata = { quality = 'Common' },
                maxStack = 500,
                client = {
                        notification = 'You checked your money'
                }
        },

        ['mustard'] = {
                label = 'Mustard',
                weight = 500,
                metadata = { quality = 'Common' },
                client = {
			status = { hunger = 25000, thirst = 25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
			usetime = 2500,
			notification = 'You.. drank mustard'
		}
	},

        ['water'] = {
                label = 'Water',
                weight = 500,
                metadata = { quality = 'Common' },
                client = {
                        status = { thirst = 200000 },
                        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 2500,
			cancel = true,
			notification = 'You drank some refreshing water'
		}
	},

        ['radio'] = {
                label = 'Radio',
                weight = 1000,
                metadata = { quality = 'Uncommon' },
                stack = false,
                allowArmed = true,
                client = {
                        notification = 'You turned on the radio'
                }
        },

        ['armour'] = {
                label = 'Bulletproof Vest',
                weight = 3000,
                metadata = { quality = 'Rare' },
                stack = false,
                client = {
                        anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
                        usetime = 3500,
                        notification = 'You donned a bulletproof vest'
                }
        },

        ['clothing'] = {
                label = 'Clothing',
                metadata = { quality = 'Common' },
                consume = 0,
                client = {
                        notification = 'You equipped some clothing'
                }
        },

        ['mastercard'] = {
                label = 'Fleeca Card',
                stack = false,
                weight = 10,
                metadata = { quality = 'Rare' },
                client = {
                        image = 'card_bank.png',
                        notification = 'You looked at your Fleeca card'
                }
        },

        ['scrapmetal'] = {
                label = 'Scrap Metal',
                weight = 80,
                metadata = { quality = 'Common' },
                client = {
                        notification = 'You examined scrap metal'
                }
        },

	["empty_weed_bag"] = {
		label = "Empty Weed Bag",
		weight = 0,
		stack = true,
		close = true,
		description = "A small empty bag",
		client = {
			image = "weed_baggy_empty.png",
		}
	},

	["surgical_tray"] = {
		label = "Surgical tray",
		weight = 500,
		stack = true,
		close = true,
		description = "edit here",
		client = {
			image = "surgical_tray.png",
		}
	},

	["largescope_attachment"] = {
		label = "Large Scope",
		weight = 1000,
		stack = true,
		close = true,
		description = "A large scope for a weapon",
		client = {
			image = "largescope_attachment.png",
		}
	},

	["burgershot_smurfetteicecream"] = {
		label = "Smurfette Ice Cream",
		weight = 100,
		stack = false,
		close = true,
		description = "Smurfette Ice Cream",
		client = {
			image = "burgershot_smurfetteicecream.png",
		}
	},

	["nos"] = {
		label = "NOS Bottle",
		weight = 0,
		stack = false,
		close = true,
		description = "A full bottle of NOS",
		client = {
			image = "nos.png",
		}
	},

	["watermelondrink"] = {
		label = "Watermelon Drink",
		weight = 1000,
		stack = true,
		close = true,
		description = "Watermelon Drink.",
		client = {
			image = "watermelondrink.png",
		}
	},

	["weed_whitewidow_seed"] = {
		label = "White Widow Seed",
		weight = 0,
		stack = true,
		close = false,
		description = "A weed seed of White Widow",
		client = {
			image = "weed_seed.png",
		}
	},

	["grape"] = {
		label = "Grape",
		weight = 100,
		stack = true,
		close = false,
		description = "Mmmmh yummie, grapes",
		client = {
			image = "grape.png",
		}
	},

	["ltbuns"] = {
		label = "Breakfast Buns",
		weight = 10,
		stack = true,
		close = true,
		description = ".",
		client = {
			image = "ltbuns.png",
		}
	},

	["fishbait"] = {
		label = "Fish Bait",
		weight = 400,
		stack = true,
		close = true,
		description = "Fishing bait",
		client = {
			image = "fishbait.png",
		}
	},

        ["diamond_ring"] = {
                label = "Diamond Ring",
                weight = 200,
                metadata = { quality = 'Legendary' },
                stack = true,
                close = false,
                description = "",
                client = {
                        image = "diamond_ring.png",
		}
	},

	["weed_ogkush"] = {
		label = "OGKush 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "A weed bag with 2g OG Kush",
		client = {
			image = "weed_baggy.png",
		}
	},

	["police_guide"] = {
		label = "Police Guide",
		weight = 1000,
		stack = true,
		close = true,
		description = "Seems to be left over",
		client = {
			image = "np_book.png",
		}
	},

	["paradisecocktail"] = {
		label = "Paradise Cocktail",
		weight = 1000,
		stack = true,
		close = true,
		description = "Living in paradise!",
		client = {
			image = "paradisecocktail.png",
		}
	},

	["phone_hack"] = {
		label = "Phone Hack",
		weight = 300,
		stack = false,
		close = true,
		description = "With this chip, you can access hidden areas of Discord.",
		client = {
			image = "phone_hack.png",
		}
	},

	["barra-manteiga"] = {
		label = "Butter Bar",
		weight = 1500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "manteiga.png",
		}
	},

	["car_armor"] = {
		label = "Vehicle Armor",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "armour.png",
		}
	},

	["police_stormram"] = {
		label = "Stormram",
		weight = 18000,
		stack = true,
		close = true,
		description = "A nice tool to break into doors",
		client = {
			image = "police_stormram.png",
		}
	},

	["boomcamo_attachment"] = {
		label = "Boom Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A boom camo for a weapon",
		client = {
			image = "boomcamo_attachment.png",
		}
	},

	["ears"] = {
		label = "Ears",
		weight = 0,
		stack = false,
		close = true,
		description = "Ears",
		client = {
			image = "ears.png",
		}
	},

	["underglow_controller"] = {
		label = "Neon Controller",
		weight = 0,
		stack = true,
		close = true,
		description = "RGB LED Vehicle Remote",
		client = {
			image = "underglow_controller.png",
		}
	},

	["laptop"] = {
		label = "Laptop",
		weight = 4000,
		stack = true,
		close = true,
		description = "Expensive laptop",
		client = {
			image = "laptop.png",
		}
	},

	["brakes2"] = {
		label = "Tier 2 Brakes",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "brakes2.png",
		}
	},

	["tires"] = {
		label = "Drift Smoke Tires",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "tires.png",
		}
	},

	["vehicletrackertablet"] = {
		label = "Vehicle Tracker Tablet",
		weight = 1000,
		stack = false,
		close = true,
		description = "Connects to a vehicle tracker to show it's location.",
		client = {
			image = "vehicletrackertablet.png",
		}
	},

	["orange"] = {
		label = "Orange",
		weight = 1000,
		stack = true,
		close = true,
		description = "an ingredient!",
		client = {
			image = "orange.png",
		}
	},

	["veh_neons"] = {
		label = "Neons",
		weight = 1000,
		stack = true,
		close = true,
		description = "Upgrade vehicle neons",
		client = {
			image = "veh_neons.png",
		}
	},

	["bubble-morango"] = {
		label = "Strawberry Bubble Tea",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "btmorango.png",
		}
	},

	["breathalyzer"] = {
		label = "Breathalyzer",
		weight = 200,
		stack = true,
		close = true,
		description = "A vintage 2000's WiWang breathalyzer engraved Property of LSPD",
		client = {
			image = "breathalyzer.png",
		}
	},

	["burgershot_bagcoffe"] = {
		label = "Coffee Package",
		weight = 100,
		stack = false,
		close = true,
		description = "1x Coffee, 1x Macaroon",
		client = {
			image = "burgershot_bagcoffe.png",
		}
	},

	["blue_phone"] = {
		label = "Blue Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "They say that Quasar Smartphone is the same as an iPhone, what do you think?",
		client = {
			image = "blue_phone.png",
		}
	},

	["c4_bomb"] = {
		label = "C4 Bomb",
		weight = 220,
		stack = true,
		close = true,
		description = "Explosive",
		client = {
			image = "np_c4.png",
		}
	},

	["frasco-nutela"] = {
		label = "Jar of Nutella",
		weight = 1500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "nutela.png",
		}
	},

	["skateboard"] = {
		label = "Skateboard",
		weight = 1,
		stack = false,
		close = true,
		description = "a jimnastic board",
		client = {
			image = "skateboard.png",
		}
	},

	["limeyschocolate"] = {
		label = "Nestle Extrafino Chocolate",
		weight = 100,
		stack = true,
		close = true,
		description = "Mmmmmm Chocolate!",
		client = {
			image = "limeyschocolate.png",
		}
	},

	["lighter"] = {
		label = "Lighter",
		weight = 0,
		stack = true,
		close = true,
		description = "On new years eve a nice fire to stand next to",
		client = {
			image = "lighter.png",
		}
	},

	["tirerepairkit"] = {
		label = "Tire Repair Kit",
		weight = 1000,
		stack = true,
		close = true,
		description = "A kit to repair your tires",
		client = {
			image = "tirerepairkit.png",
		}
	},

	["rolling_paper"] = {
		label = "Rolling Paper",
		weight = 0,
		stack = true,
		close = true,
		description = "Paper made specifically for encasing and smoking tobacco or cannabis.",
		client = {
			image = "rolling_paper.png",
		}
	},

	["veh_transmission"] = {
		label = "Transmission",
		weight = 1000,
		stack = true,
		close = true,
		description = "Upgrade vehicle transmission",
		client = {
			image = "veh_transmission.png",
		}
	},

	["burgershot_meat"] = {
		label = "Meat",
		weight = 100,
		stack = false,
		close = true,
		description = "Meat",
		client = {
			image = "burgershot_meat.png",
		}
	},

	["noscan"] = {
		label = "Empty NOS Bottle",
		weight = 0,
		stack = true,
		close = true,
		description = "An Empty bottle of NOS",
		client = {
			image = "noscan.png",
		}
	},

	["aluminumoxide"] = {
		label = "Aluminium Powder",
		weight = 100,
		stack = true,
		close = false,
		description = "Some powder to mix with",
		client = {
			image = "aluminumoxide.png",
		}
	},

	["labkey"] = {
		label = "Key",
		weight = 500,
		stack = false,
		close = true,
		description = "Key for a lock...?",
		client = {
			image = "labkey.png",
		}
	},

	["twerks_candy"] = {
		label = "Twerks",
		weight = 100,
		stack = true,
		close = true,
		description = "Some delicious candy :O",
		client = {
			image = "twerks_candy.png",
		}
	},

	["fishingrod"] = {
		label = "Fishing Rod",
		weight = 750,
		stack = true,
		close = true,
		description = "A fishing rod for adventures with friends!!",
		client = {
			image = "fishingrod.png",
		}
	},

	["pastel-frango"] = {
		label = "Chicken Pastel",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pfrango.png",
		}
	},

	["rollcage"] = {
		label = "Roll Cage",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "rollcage.png",
		}
	},

	["burgershot_toy6"] = {
		label = "Burger Shot Toy",
		weight = 100,
		stack = false,
		close = true,
		description = "Burger Shot Toy",
		client = {
			image = "burgershot_toy6.png",
		}
	},

	["veh_suspension"] = {
		label = "Suspension",
		weight = 1000,
		stack = true,
		close = true,
		description = "Upgrade vehicle suspension",
		client = {
			image = "veh_suspension.png",
		}
	},

	["flounder"] = {
		label = "Flounder",
		weight = 2500,
		stack = false,
		close = false,
		description = "Flounder",
		client = {
			image = "flounder.png",
		}
	},

	["engine3"] = {
		label = "Tier 3 Engine",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "engine3.png",
		}
	},

	["fishingboot"] = {
		label = "Fishing Boot",
		weight = 2500,
		stack = true,
		close = false,
		description = "Fishing Boot",
		client = {
			image = "fishingboot.png",
		}
	},

	["burgershot_strawberryicecream"] = {
		label = "Strawberry Ice Cream",
		weight = 100,
		stack = false,
		close = true,
		description = "Strawberry Ice Cream",
		client = {
			image = "burgershot_strawberryicecream.png",
		}
	},

	["sapphire_ring"] = {
		label = "Sapphire Ring",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sapphire_ring.png",
		}
	},

	["spray_remover"] = {
		label = "Spray Removal Kit",
		weight = 300,
		stack = true,
		close = true,
		description = "Remove the sprays, increase the heat btw gangs!",
		client = {
			image = "spray_remover.png",
		}
	},

	["gatecrack"] = {
		label = "Gatecrack",
		weight = 0,
		stack = true,
		close = true,
		description = "Handy software to tear down some fences",
		client = {
			image = "usb_device.png",
		}
	},

	["tunerlaptop"] = {
		label = "Tunerchip",
		weight = 2000,
		stack = false,
		close = true,
		description = "With this tunerchip you can get your car on steroids... If you know what you're doing",
		client = {
			image = "tunerchip.png",
		}
	},

	["paintcan"] = {
		label = "Vehicle Spray Can",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "spraycan.png",
		}
	},

	["spikespack"] = {
		label = "Spikes Pack",
		weight = 0,
		stack = false,
		close = true,
		description = "A 5 spikes pack for your needs.",
		client = {
			image = "spikespack.png",
		}
	},

	["wet__phone"] = {
		label = "Wet Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Did you really think that swimming in the ocean with your phone was a good idea?",
		client = {
			image = "wet_classic_phone.png",
		}
	},

	["driver_license"] = {
		label = "Drivers License",
		weight = 0,
		stack = false,
		close = false,
		description = "Permit to show you can drive a vehicle",
		client = {
			image = "driver_license.png",
		}
	},

	["blueberries"] = {
		label = "Blueberries",
		weight = 10,
		stack = true,
		close = true,
		description = "Blueberries.",
		client = {
			image = "blueberries.png",
		}
	},

	["wet_red_phone"] = {
		label = "Wet Red Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Did you really think that swimming in the ocean with your phone was a good idea?",
		client = {
			image = "wet_red_phone.png",
		}
	},

	["cocktailglass"] = {
		label = "Cocktail Glass",
		weight = 1000,
		stack = true,
		close = true,
		description = "Glass made for cocktails!",
		client = {
			image = "cocktailglass.png",
		}
	},

	["uncut_emerald"] = {
		label = "Uncut Emerald",
		weight = 100,
		stack = true,
		close = false,
		description = "A rough Emerald",
		client = {
			image = "uncut_emerald.png",
		}
	},

	["body_cam"] = {
		label = "Body Cam",
		weight = 0,
		stack = false,
		close = true,
		description = "Body cam for law enforcers",
		client = {
			image = "bodycam.png",
		}
	},

	["graos-cafe"] = {
		label = "Coffee Beans",
		weight = 1500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "graoscafe.png",
		}
	},

	["fishinglootbig"] = {
		label = "Treasure Chest",
		weight = 2500,
		stack = true,
		close = true,
		description = "The lock seems to be intact, Might need a key",
		client = {
			image = "fishinglootbig.png",
		}
	},

	["security_card_02"] = {
		label = "Security Card B",
		weight = 0,
		stack = true,
		close = true,
		description = "A security card... I wonder what it goes to",
		client = {
			image = "security_card_02.png",
		}
	},

	["ltcookies"] = {
		label = "Cookie",
		weight = 10,
		stack = true,
		close = true,
		description = "Cookies",
		client = {
			image = "ltcookies.png",
		}
	},

	["jerry_can"] = {
		label = "Jerrycan 20L",
		weight = 20000,
		stack = true,
		close = true,
		description = "A can full of Fuel",
		client = {
			image = "jerry_can.png",
		}
	},

	["burgershot_frozenrings"] = {
		label = "Frozen Rings",
		weight = 100,
		stack = false,
		close = true,
		description = "Frozen Rings",
		client = {
			image = "burgershot_frozenrings.png",
		}
	},

	["latte-uwu"] = {
		label = "Latte",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "latte.png",
		}
	},

	["componet_gavel"] = {
		label = "Gavel",
		weight = 1000,
		stack = false,
		close = true,
		description = "PLAY BALL!",
		client = {
			image = "weapon_gavel.png",
		}
	},

	["comp_attachment"] = {
		label = "Compensator",
		weight = 1000,
		stack = true,
		close = true,
		description = "A compensator for a weapon",
		client = {
			image = "comp_attachment.png",
		}
	},

	["eblower"] = {
		label = "Electric Blower",
		weight = 2000,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "eblower.png",
		}
	},

	["thermite_bomb"] = {
		label = "Thermite Bomb",
		weight = 100,
		stack = true,
		close = true,
		description = "Explosive",
		client = {
			image = "thermite.png",
		}
	},

	["pacote-acucar"] = {
		label = "Sugar Pack",
		weight = 1500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "acucar.png",
		}
	},

	["arms"] = {
		label = "Arms",
		weight = 0,
		stack = false,
		close = true,
		description = "Arms",
		client = {
			image = "arms.png",
		}
	},

	["veh_xenons"] = {
		label = "Xenons",
		weight = 1000,
		stack = true,
		close = true,
		description = "Upgrade vehicle xenons",
		client = {
			image = "veh_xenons.png",
		}
	},

	["burgershot_sauce"] = {
		label = "Sauce",
		weight = 100,
		stack = false,
		close = true,
		description = "Sauce",
		client = {
			image = "burgershot_sauce.png",
		}
	},

	["banana"] = {
		label = "Banana",
		weight = 1000,
		stack = true,
		close = true,
		description = "an ingredient!",
		client = {
			image = "banana.png",
		}
	},

	["gelado-morango"] = {
		label = "Strawberry Icecream",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "gemorango.png",
		}
	},

	["watermelonslice"] = {
		label = "Watermelon Slice",
		weight = 200,
		stack = true,
		close = true,
		description = "an ingredient!",
		client = {
			image = "watermelonslice.png",
		}
	},

	["oxy"] = {
		label = "Prescription Oxy",
		weight = 0,
		stack = true,
		close = true,
		description = "The Label Has Been Ripped Off",
		client = {
			image = "oxy.png",
		}
	},

	["trowel"] = {
		label = "Trowel",
		weight = 350,
		stack = true,
		close = true,
		description = "Mini-shovel yes",
		client = {
			image = "trowel.png",
		}
	},

	["burgershot_toy5"] = {
		label = "Burger Shot Toy",
		weight = 100,
		stack = false,
		close = true,
		description = "Burger Shot Toy",
		client = {
			image = "burgershot_toy5.png",
		}
	},

	["barrel_attachment"] = {
		label = "Barrel",
		weight = 1000,
		stack = true,
		close = true,
		description = "A barrel for a weapon",
		client = {
			image = "barrel_attachment.png",
		}
	},

	["sapphire_ring_silver"] = {
		label = "Sapphire Ring Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sapphire_ring_silver.png",
		}
	},

	["flat_muzzle_brake"] = {
		label = "Flat Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brake for a weapon",
		client = {
			image = "flat_muzzle_brake.png",
		}
	},

	["bananacocktail"] = {
		label = "Banana Cocktail",
		weight = 1000,
		stack = true,
		close = true,
		description = "The Minions made this.",
		client = {
			image = "bananacocktail.png",
		}
	},

	["nikon"] = {
		label = "Nikoff G900",
		weight = 1000,
		stack = false,
		close = true,
		description = "Caught in 4K",
		client = {
			image = "nikon.png",
		}
	},

	["electronickit"] = {
		label = "Electronic Kit",
		weight = 100,
		stack = true,
		close = true,
		description = "If you've always wanted to build a robot you can maybe start here. Maybe you'll be the new Elon Musk?",
		client = {
			image = "electronickit.png",
		}
	},

	["casino_vip"] = {
		label = "V.I.P Membership",
		weight = 500,
		stack = false,
		close = false,
		description = "Diamond Casino V.I.P Card",
		client = {
			image = "casino_vip.png",
		}
	},

	["cupcake-limao"] = {
		label = "Lemon Cupcake",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cuplimao.png",
		}
	},

	["cleanershovel"] = {
		label = "Mini Shovel",
		weight = 2000,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "cleanershovel.png",
		}
	},

	["burgershot_smallemptyglass"] = {
		label = "Small Size Empty Glass",
		weight = 100,
		stack = false,
		close = true,
		description = "Small Size Empty Glass",
		client = {
			image = "burgershot_smallemptyglass.png",
		}
	},

	["codfish"] = {
		label = "Cod",
		weight = 2500,
		stack = false,
		close = false,
		description = "Cod",
		client = {
			image = "codfish.png",
		}
	},

	["squared_muzzle_brake"] = {
		label = "Squared Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brake for a weapon",
		client = {
			image = "squared_muzzle_brake.png",
		}
	},

	["ltcheese"] = {
		label = "LT Cheese",
		weight = 10,
		stack = true,
		close = true,
		description = ".",
		client = {
			image = "ltcheese.png",
		}
	},

	["wine"] = {
		label = "Wine",
		weight = 300,
		stack = true,
		close = false,
		description = "Some good wine to drink on a fine evening",
		client = {
			image = "wine.png",
		}
	},

	["weedpackage"] = {
		label = "Weed Package",
		weight = 15000,
		stack = false,
		close = false,
		description = "A large & hastly sealed package with a herbal aroma",
		client = {
			image = "weedpackage.png",
		}
	},

	["anchor"] = {
		label = "Boat Anchor",
		weight = 2500,
		stack = true,
		close = true,
		description = "Boat Anchor",
		client = {
			image = "anchor.png",
		}
	},

	["bottle"] = {
		label = "Empty Bottle",
		weight = 10,
		stack = true,
		close = false,
		description = "A glass bottle",
		client = {
			image = "bottle.png",
		}
	},

	["burgershot_bleeder"] = {
		label = "Bleeder Burger",
		weight = 100,
		stack = false,
		close = true,
		description = "Bleeder Burger",
		client = {
			image = "burgershot_bleeder.png",
		}
	},

	["cherry"] = {
		label = "Cherry",
		weight = 1000,
		stack = true,
		close = true,
		description = "an ingredient!",
		client = {
			image = "cherry.png",
		}
	},

	["cupcake-morango"] = {
		label = "Strawberry Cupcake",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cupmorango.png",
		}
	},

	["mackerel"] = {
		label = "Mackerel",
		weight = 2500,
		stack = false,
		close = false,
		description = "Mackerel",
		client = {
			image = "mackerel.png",
		}
	},

	["pacote-farinha"] = {
		label = "Flour Package",
		weight = 1500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "farinha.png",
		}
	},

	["milkshake-chocolate"] = {
		label = "Chocolate Milkshake",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "mschocolate.png",
		}
	},

	["slanted_muzzle_brake"] = {
		label = "Slanted Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brake for a weapon",
		client = {
			image = "slanted_muzzle_brake.png",
		}
	},

	["diamond_earring_silver"] = {
		label = "Diamond Earrings Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "diamond_earring_silver.png",
		}
	},

	["drink-glass"] = {
		label = "Glass",
		weight = 1000,
		stack = true,
		close = true,
		description = "Glass made for normal drinks",
		client = {
			image = "drink-glass.png",
		}
	},

	["engine2"] = {
		label = "Tier 2 Engine",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "engine2.png",
		}
	},

	["surgical_gloves"] = {
		label = "Surgical gloves",
		weight = 500,
		stack = true,
		close = true,
		description = "edit here",
		client = {
			image = "surgical_gloves.png",
		}
	},

	["ltdonut"] = {
		label = "Donut",
		weight = 10,
		stack = true,
		close = true,
		description = "Donut",
		client = {
			image = "ltdonut.png",
		}
	},

	["weed_amnesia_seed"] = {
		label = "Amnesia Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "A weed seed of Amnesia",
		client = {
			image = "weed_seed.png",
		}
	},

	["ltlettuce"] = {
		label = "Lettuce",
		weight = 10,
		stack = true,
		close = true,
		description = ".",
		client = {
			image = "ltlettuce.png",
		}
	},

	["burgershot_bagsmall"] = {
		label = "Small Size Package",
		weight = 100,
		stack = false,
		close = true,
		description = "1x Bleeder Burger, 1x Small Size Cola, 1x Small Size Patato",
		client = {
			image = "burgershot_bagsmall.png",
		}
	},

	["drifttires"] = {
		label = "Drift Tires",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "drifttires.png",
		}
	},

	["weed_purplehaze"] = {
		label = "Purple Haze 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "A weed bag with 2g Purple Haze",
		client = {
			image = "weed_baggy.png",
		}
	},

	["pancakesbb"] = {
		label = "Blueberry Pancakes",
		weight = 10,
		stack = true,
		close = true,
		description = "Yum.",
		client = {
			image = "pancakesbb.png",
		}
	},

	["burgershot_smallcardboard"] = {
		label = "Small Size Cardboard",
		weight = 100,
		stack = false,
		close = true,
		description = "Small Size Cardboard",
		client = {
			image = "burgershot_smallcardboard.png",
		}
	},

	["burgershot_toy3"] = {
		label = "Burger Shot Toy",
		weight = 100,
		stack = false,
		close = true,
		description = "Burger Shot Toy",
		client = {
			image = "burgershot_toy3.png",
		}
	},

	["silverchain"] = {
		label = "Silver Chain",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "silverchain.png",
		}
	},

	["recyclablematerial"] = {
		label = "Recycle Box",
		weight = 100,
		stack = true,
		close = false,
		description = "A box of Recyclable Materials",
		client = {
			image = "recyclablematerial.png",
		}
	},

	["armor"] = {
		label = "Armor",
		weight = 5000,
		stack = true,
		close = true,
		description = "Some protection won't hurt... right?",
		client = {
			image = "armor.png",
		}
	},

	["cash_bag"] = {
		label = "Gruppe 6 Cash Bag",
		weight = 1000,
		stack = true,
		close = false,
		description = "Bag full of un-inked cash",
		client = {
			image = "cash_bag.png",
		}
	},

	["ltcroissant"] = {
		label = "Croissant",
		weight = 10,
		stack = true,
		close = true,
		description = "Croissant",
		client = {
			image = "ltcroissant.png",
		}
	},

	["torso"] = {
		label = "Torso",
		weight = 0,
		stack = false,
		close = true,
		description = "Torso",
		client = {
			image = "torso.png",
		}
	},

	["repairkit"] = {
		label = "Repairkit",
		weight = 2500,
		stack = true,
		close = true,
		description = "A nice toolbox with stuff to repair your vehicle",
		client = {
			image = "repairkit.png",
		}
	},

	["panqueca-nutela"] = {
		label = "Nutella Pancake",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "panutela.png",
		}
	},

	["burgershot_ubeicecream"] = {
		label = "Ube Ice Cream",
		weight = 100,
		stack = false,
		close = true,
		description = "Ube Ice Cream",
		client = {
			image = "burgershot_ubeicecream.png",
		}
	},

	["kiwi"] = {
		label = "Kiwi",
		weight = 1000,
		stack = true,
		close = true,
		description = "an ingredient!",
		client = {
			image = "kiwi.png",
		}
	},

	["burgershot_frozenmeat"] = {
		label = "Frozen Meat",
		weight = 100,
		stack = false,
		close = true,
		description = "Frozen Meat",
		client = {
			image = "burgershot_frozenmeat.png",
		}
	},

	["burgershot_chocolateicecream"] = {
		label = "Chocolate Ice Cream",
		weight = 100,
		stack = false,
		close = true,
		description = "Chocolate Ice Cream",
		client = {
			image = "burgershot_chocolateicecream.png",
		}
	},

	["burgershot_unicornicecream"] = {
		label = "Unicorn Ice Cream",
		weight = 100,
		stack = false,
		close = true,
		description = "Unicorn Ice Cream",
		client = {
			image = "burgershot_unicornicecream.png",
		}
	},

	["gold_ring"] = {
		label = "Gold Ring",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "gold_ring.png",
		}
	},

	["coffee"] = {
		label = "Coffee",
		weight = 200,
		stack = true,
		close = true,
		description = "Pump 4 Caffeine",
		client = {
			image = "coffee.png",
		}
	},

	["bellend_muzzle_brake"] = {
		label = "Bellend Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brake for a weapon",
		client = {
			image = "bellend_muzzle_brake.png",
		}
	},

	["watermelon"] = {
		label = "Watermelon",
		weight = 1000,
		stack = true,
		close = true,
		description = "a sliceable watermelon!",
		client = {
			image = "watermelon.png",
		}
	},

	["emerald"] = {
		label = "Emerald",
		weight = 100,
		stack = true,
		close = false,
		description = "A Emerald that shimmers",
		client = {
			image = "emerald.png",
		}
	},

	["nitrous"] = {
		label = "Nitrous",
		weight = 1000,
		stack = true,
		close = true,
		description = "Speed up, gas pedal! :D",
		client = {
			image = "nitrous.png",
		}
	},

	["fitbit"] = {
		label = "Fitbit",
		weight = 500,
		stack = false,
		close = true,
		description = "I like fitbit",
		client = {
			image = "fitbit.png",
		}
	},

	["ltmango"] = {
		label = "Mango",
		weight = 10,
		stack = true,
		close = true,
		description = "Mango",
		client = {
			image = "ltmango.png",
		}
	},

	["pacote-natas"] = {
		label = "Package of Cream",
		weight = 1500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "natas.png",
		}
	},

	["weed_purplehaze_seed"] = {
		label = "Purple Haze Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "A weed seed of Purple Haze",
		client = {
			image = "weed_seed.png",
		}
	},

	["burgershot_toy1"] = {
		label = "Burger Shot Toy",
		weight = 100,
		stack = false,
		close = true,
		description = "Burger Shot Toy",
		client = {
			image = "burgershot_toy1.png",
		}
	},

	["seat"] = {
		label = "Seat Cosmetics",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "seat.png",
		}
	},

	["whiskey"] = {
		label = "Whiskey",
		weight = 1000,
		stack = true,
		close = true,
		description = "This is not a bottle of booze!",
		client = {
			image = "whiskey.png",
		}
	},

	["veh_plates"] = {
		label = "Plates",
		weight = 1000,
		stack = true,
		close = true,
		description = "Install vehicle plates",
		client = {
			image = "veh_plates.png",
		}
	},

	["goldchain"] = {
		label = "Golden Chain",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "goldchain.png",
		}
	},

	["radiator"] = {
		label = "Car Radiator",
		weight = 10000,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "car_radiator.png",
		}
	},

	["pink_phone"] = {
		label = "Pink Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "They say that Quasar Smartphone is the same as an iPhone, what do you think?",
		client = {
			image = "pink_phone.png",
		}
	},

	["aluminum"] = {
		label = "Aluminium",
		weight = 100,
		stack = true,
		close = false,
		description = "Nice piece of metal that you can probably use for something",
		client = {
			image = "aluminum.png",
		}
	},

	["firstaid"] = {
		label = "First Aid",
		weight = 2500,
		stack = true,
		close = true,
		description = "You can use this First Aid kit to get people back on their feet",
		client = {
			image = "firstaid.png",
		}
	},

	["antipatharia_coral"] = {
		label = "Antipatharia",
		weight = 1000,
		stack = true,
		close = true,
		description = "Its also known as black corals or thorn corals",
		client = {
			image = "antipatharia_coral.png",
		}
	},

	["medscope_attachment"] = {
		label = "Medium Scope",
		weight = 1000,
		stack = true,
		close = true,
		description = "A medium scope for a weapon",
		client = {
			image = "medscope_attachment.png",
		}
	},

	["bank_card"] = {
		label = "Bank Card",
		weight = 0,
		stack = false,
		close = true,
		description = "Used to access ATM",
		client = {
			image = "bank_card.png",
		}
	},

	["red_phone"] = {
		label = "Red Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "They say that Quasar Smartphone is the same as an iPhone, what do you think?",
		client = {
			image = "red_phone.png",
		}
	},

	["miningdrill"] = {
		label = "Mining Drill",
		weight = 1000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "miningdrill.png",
		}
	},

	["roof"] = {
		label = "Vehicle Roof",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "roof.png",
		}
	},

	["coke_brick"] = {
		label = "Coke Brick",
		weight = 1000,
		stack = false,
		close = true,
		description = "Heavy package of cocaine, mostly used for deals and takes a lot of space",
		client = {
			image = "coke_brick.png",
		}
	},

	["sparkplugs"] = {
		label = "Spark Plugs",
		weight = 0,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sparkplugs.png",
		}
	},

	["wet_green_phone"] = {
		label = "Wet Green Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "They say that Quasar Smartphone is the same as an iPhone, what do you think?",
		client = {
			image = "wet_green_phone.png",
		}
	},

	["wet_blue_phone"] = {
		label = "Wet Blue Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Did you really think that swimming in the ocean with your phone was a good idea?",
		client = {
			image = "wet_blue_phone.png",
		}
	},

	["dirty_potato"] = {
		label = "Dirty Potato",
		weight = 350,
		stack = true,
		close = true,
		description = "Po-ta-to",
		client = {
			image = "dirty_potato.png",
		}
	},

	["package"] = {
		label = "Suspicious Package",
		weight = 10000,
		stack = false,
		close = false,
		description = "A mysterious package.. Scary!",
		client = {
			image = "package.png",
		}
	},

	["ltmuffin"] = {
		label = "Muffin Bun",
		weight = 10,
		stack = true,
		close = true,
		description = ".",
		client = {
			image = "ltmuffin.png",
		}
	},

	["cokebaggy"] = {
		label = "Bag of Coke",
		weight = 0,
		stack = true,
		close = true,
		description = "To get happy real quick",
		client = {
			image = "cocaine_baggy.png",
		}
	},

	["tactical_muzzle_brake"] = {
		label = "Tactical Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brakee for a weapon",
		client = {
			image = "tactical_muzzle_brake.png",
		}
	},

	["limeyschocolate2"] = {
		label = "Cadbury Dairy Milk Chocolate",
		weight = 100,
		stack = true,
		close = true,
		description = "Cadbury Chocolate!",
		client = {
			image = "limeyschocolate2.png",
		}
	},

	["metalscrap"] = {
		label = "Metal Scrap",
		weight = 100,
		stack = true,
		close = false,
		description = "You can probably make something nice out of this",
		client = {
			image = "metalscrap.png",
		}
	},

	["casinochips"] = {
		label = "Casino Chips",
		weight = 0,
		stack = true,
		close = false,
		description = "Chips For Casino Gambling",
		client = {
			image = "casinochips.png",
		}
	},

	["trojan_usb"] = {
		label = "Trojan USB",
		weight = 0,
		stack = true,
		close = true,
		description = "Handy software to shut down some systems",
		client = {
			image = "usb_device.png",
		}
	},

	["fishingtin"] = {
		label = "Fishing Tin",
		weight = 2500,
		stack = true,
		close = false,
		description = "Fishing Tin",
		client = {
			image = "fishingtin.png",
		}
	},

	["veh_exterior"] = {
		label = "Exterior",
		weight = 1000,
		stack = true,
		close = true,
		description = "Upgrade vehicle exterior",
		client = {
			image = "veh_exterior.png",
		}
	},

	["ltstrawberry"] = {
		label = "Strawberries",
		weight = 10,
		stack = true,
		close = true,
		description = "Strawberries",
		client = {
			image = "ltstrawberry.png",
		}
	},

	["burgershot_macaroon"] = {
		label = "Macaroon",
		weight = 100,
		stack = false,
		close = true,
		description = "Macaroon",
		client = {
			image = "burgershot_macaroon.png",
		}
	},

	["axleparts"] = {
		label = "Axle Parts",
		weight = 0,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "axleparts.png",
		}
	},

	["cherrydrink"] = {
		label = "Cherry Drink",
		weight = 1000,
		stack = true,
		close = true,
		description = "Cherries!",
		client = {
			image = "cherrydrink.png",
		}
	},

	["spray"] = {
		label = "Spray Paint",
		weight = 300,
		stack = true,
		close = false,
		description = "Spray Anywhere Boys",
		client = {
			image = "spray.png",
		}
	},

	["markedbills"] = {
		label = "Marked Money",
		weight = 1000,
		stack = false,
		close = true,
		description = "Money?",
		client = {
			image = "markedbills.png",
		}
	},

	["burgershot_colas"] = {
		label = "Small Size Cola",
		weight = 100,
		stack = false,
		close = true,
		description = "Small Size Cola",
		client = {
			image = "burgershot_colas.png",
		}
	},

	["vehicletracker"] = {
		label = "Vehicle GPS Tracker",
		weight = 1000,
		stack = false,
		close = true,
		description = "A device placed to track a vehicle's location.",
		client = {
			image = "vehicletracker.png",
		}
	},

	["fishtacklebox"] = {
		label = "Tackle Box",
		weight = 1000,
		stack = true,
		close = true,
		description = "Seems to be left over tackle box from another fisherman",
		client = {
			image = "fishtacklebox.png",
		}
	},

	["diamond_necklace_silver"] = {
		label = "Diamond Necklace Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "diamond_necklace_silver.png",
		}
	},

	["bubble-amora"] = {
		label = "Blackberry Bubble Tea",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "btamora.png",
		}
	},

	["suspension1"] = {
		label = "Tier 1 Suspension",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "suspension1.png",
		}
	},

	["pill"] = {
		label = "Pill",
		weight = 500,
		stack = true,
		close = true,
		description = "edit here",
		client = {
			image = "pill.png",
		}
	},

	["rims"] = {
		label = "Custom Wheel Rims",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "rims.png",
		}
	},

	["diamond"] = {
		label = "Diamond",
		weight = 100,
		stack = true,
		close = false,
		description = "A Diamond that shimmers",
		client = {
			image = "diamond.png",
		}
	},

	["emerald_necklace_silver"] = {
		label = "Emerald Necklace Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "emerald_necklace_silver.png",
		}
	},

	["pacote-leite"] = {
		label = "Milk Pack",
		weight = 1500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "leite.png",
		}
	},

	["emerald_ring"] = {
		label = "Emerald Ring",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "emerald_ring.png",
		}
	},

	["bands"] = {
		label = "Band Of Notes",
		weight = 100,
		stack = true,
		close = false,
		description = "A band of small notes..",
		client = {
			image = "cashstack.png",
		}
	},

	["wet_greenlight_phone"] = {
		label = "Wet Green Light Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "They say that Quasar Smartphone is the same as an iPhone, what do you think?",
		client = {
			image = "wet_greenlight_phone.png",
		}
	},

	["fishingkey"] = {
		label = "Corroded Key",
		weight = 100,
		stack = true,
		close = true,
		description = "A weathered key that looks usefull",
		client = {
			image = "fishingkey.png",
		}
	},

	["frango"] = {
		label = "Chicken",
		weight = 1500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "frango.png",
		}
	},

	["guide"] = {
		label = "Server Guide",
		weight = 100,
		stack = true,
		close = true,
		description = "A weathered key that looks usefull",
		client = {
			image = "np_book.png",
		}
	},

	["limedrink"] = {
		label = "Lime Drink",
		weight = 1000,
		stack = true,
		close = true,
		description = "Limes...",
		client = {
			image = "limedrink.png",
		}
	},

	["hood"] = {
		label = "Vehicle Hood",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "hood.png",
		}
	},

	["engine1"] = {
		label = "Tier 1 Engine",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "engine1.png",
		}
	},

	["goldore"] = {
		label = "Gold Ore",
		weight = 1000,
		stack = true,
		close = false,
		description = "Gold Ore",
		client = {
			image = "goldore.png",
		}
	},

	["can"] = {
		label = "Empty Can",
		weight = 10,
		stack = true,
		close = false,
		description = "An empty can, good for recycling",
		client = {
			image = "can.png",
		}
	},

	["shoes"] = {
		label = "Shoes",
		weight = 0,
		stack = false,
		close = true,
		description = "Shoes",
		client = {
			image = "shoes.png",
		}
	},

	["burgershot_shotrings"] = {
		label = "Shot Rings",
		weight = 100,
		stack = false,
		close = true,
		description = "Shot Rings",
		client = {
			image = "burgershot_shotrings.png",
		}
	},

	["kiwicocktail"] = {
		label = "Kiwi Cocktail",
		weight = 1000,
		stack = true,
		close = true,
		description = "Kiwi.",
		client = {
			image = "kiwicocktail.png",
		}
	},

	["transmission2"] = {
		label = "Tier 2 Transmission",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "transmission2.png",
		}
	},

	["baconegg"] = {
		label = "B.E Muffin",
		weight = 10,
		stack = true,
		close = true,
		description = "Like McDonalds but better.",
		client = {
			image = "baconegg.png",
		}
	},

	["burgershot_tomato"] = {
		label = "Tomato",
		weight = 100,
		stack = false,
		close = true,
		description = "Tomato",
		client = {
			image = "burgershot_tomato.png",
		}
	},

	["emerald_earring"] = {
		label = "Emerald Earrings",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "emerald_earring.png",
		}
	},

	["rolex"] = {
		label = "Golden Watch",
		weight = 1500,
		stack = true,
		close = true,
		description = "A golden watch seems like the jackpot to me!",
		client = {
			image = "rolex.png",
		}
	},

	["uncut_ruby"] = {
		label = "Uncut Ruby",
		weight = 100,
		stack = true,
		close = false,
		description = "A rough Ruby",
		client = {
			image = "uncut_ruby.png",
		}
	},

	["smallscope_attachment"] = {
		label = "Small Scope",
		weight = 1000,
		stack = true,
		close = true,
		description = "A small scope for a weapon",
		client = {
			image = "smallscope_attachment.png",
		}
	},

	["burgershot_vanillaicecream"] = {
		label = "Vanilla Ice Cream",
		weight = 100,
		stack = false,
		close = true,
		description = "Vanilla Ice Cream",
		client = {
			image = "burgershot_vanillaicecream.png",
		}
	},

	["cctv_tablet"] = {
		label = "CCTV Tablet",
		weight = 100,
		stack = false,
		close = true,
		description = "Tablet where we can see things ahaha",
		client = {
			image = "cctv_tablet.png",
		}
	},

	["ruby_necklace_silver"] = {
		label = "Ruby Necklace Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ruby_necklace_silver.png",
		}
	},

	["silverore"] = {
		label = "Silver Ore",
		weight = 1000,
		stack = true,
		close = false,
		description = "Silver Ore",
		client = {
			image = "silverore.png",
		}
	},

	["lteggs"] = {
		label = "LT Eggs",
		weight = 10,
		stack = true,
		close = true,
		description = ".",
		client = {
			image = "lteggs.png",
		}
	},

	["gelado-chocolate"] = {
		label = "Chocolate Icecream",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "gechocolate.png",
		}
	},

	["fat_end_muzzle_brake"] = {
		label = "Fat End Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brake for a weapon",
		client = {
			image = "fat_end_muzzle_brake.png",
		}
	},

	["potato"] = {
		label = "Potato",
		weight = 350,
		stack = true,
		close = true,
		description = "Po-ta-to",
		client = {
			image = "potato.png",
		}
	},

	["headlights"] = {
		label = "Xenon Headlights",
		weight = 0,
		stack = false,
		close = true,
		description = "8k HID headlights",
		client = {
			image = "headlights.png",
		}
	},

	["dendrogyra_coral"] = {
		label = "Dendrogyra",
		weight = 1000,
		stack = true,
		close = true,
		description = "Its also known as pillar coral",
		client = {
			image = "dendrogyra_coral.png",
		}
	},

	["shovel"] = {
		label = "Shovel",
		weight = 350,
		stack = true,
		close = true,
		description = "Legit shovel yes",
		client = {
			image = "shovel.png",
		}
	},

	["oranges"] = {
		label = "Oranges",
		weight = 10,
		stack = true,
		close = true,
		description = ".",
		client = {
			image = "oranges.png",
		}
	},

	["burgershot_lavash"] = {
		label = "Lavash",
		weight = 100,
		stack = false,
		close = true,
		description = "Lavash",
		client = {
			image = "burgershot_lavash.png",
		}
	},

	["weed_amnesia"] = {
		label = "Amnesia 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "A weed bag with 2g Amnesia",
		client = {
			image = "weed_baggy.png",
		}
	},

	["thermalscope_attachment"] = {
		label = "Thermal Scope",
		weight = 1000,
		stack = true,
		close = true,
		description = "A thermal scope for a weapon",
		client = {
			image = "thermalscope_attachment.png",
		}
	},

	["radioscanner"] = {
		label = "Radio Scanner",
		weight = 1000,
		stack = true,
		close = true,
		description = "With this you can get some police alerts. Not 100% effective however",
		client = {
			image = "radioscanner.png",
		}
	},

	["internals"] = {
		label = "Internal Cosmetics",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "internals.png",
		}
	},

	["weaponlicense"] = {
		label = "Weapon License",
		weight = 0,
		stack = false,
		close = true,
		description = "Weapon License",
		client = {
			image = "weapon_license.png",
		}
	},

	["screwdriverset"] = {
		label = "Toolkit",
		weight = 1000,
		stack = true,
		close = false,
		description = "Very useful to screw... screws...",
		client = {
			image = "screwdriverset.png",
		}
	},

	["trunk"] = {
		label = "Car Trunk",
		weight = 10000,
		stack = false,
		close = true,
		client = {
			image = "car_trunk.png",
		}
	},

	["pacote-oreo"] = {
		label = "Oreo Pack",
		weight = 1500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "oreo.png",
		}
	},

	["wallet"] = {
		label = "Wallet",
		weight = 350,
		stack = true,
		close = true,
		description = "Dont Leave it ANYWHERE!",
		client = {
			image = "wallet.png",
		}
	},

	["pickaxe"] = {
		label = "Pickaxe",
		weight = 1000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "pickaxe.png",
		}
	},

	["noscolour"] = {
		label = "NOS Colour Injector",
		weight = 0,
		stack = true,
		close = true,
		description = "Make that purge spray",
		client = {
			image = "noscolour.png",
		}
	},

	["syphoningkit"] = {
		label = "Syphoning Kit",
		weight = 5000,
		stack = false,
		close = false,
		description = "A kit made to siphon gasoline from vehicles.",
		client = {
			image = "syphoningkit.png",
		}
	},

	["leite-condensado"] = {
		label = "Condensed Milk",
		weight = 1500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "condensado.png",
		}
	},

	["cherrycocktail"] = {
		label = "Cherry Cocktail",
		weight = 1000,
		stack = true,
		close = true,
		description = "Cherries.. But with whiskey",
		client = {
			image = "cherrycocktail.png",
		}
	},

	["coffeebeans"] = {
		label = "Coffee Beans",
		weight = 10,
		stack = true,
		close = true,
		description = ".",
		client = {
			image = "coffeebeans.png",
		}
	},

	["ruby_earring"] = {
		label = "Ruby Earrings",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ruby_earring.png",
		}
	},

	["weed_ogkush_seed"] = {
		label = "OGKush Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "A weed seed of OG Kush",
		client = {
			image = "weed_seed.png",
		}
	},

	["meth"] = {
		label = "Meth",
		weight = 100,
		stack = true,
		close = true,
		description = "A baggie of Meth",
		client = {
			image = "meth_baggy.png",
		}
	},

	["accesstool"] = {
		label = "Access Tool",
		weight = 500,
		stack = false,
		close = true,
		description = "Snap into an access tool.",
		client = {
			image = "accesstool.png",
		}
	},

	["copperore"] = {
		label = "Copper Ore",
		weight = 1000,
		stack = true,
		close = false,
		description = "Copper, a base ore.",
		client = {
			image = "copperore.png",
		}
	},

	["veh_toolbox"] = {
		label = "Toolbox",
		weight = 1000,
		stack = true,
		close = true,
		description = "Check vehicle status",
		client = {
			image = "veh_toolbox.png",
		}
	},

	["id_card"] = {
		label = "ID Card",
		weight = 0,
		stack = false,
		close = false,
		description = "A card containing all your information to identify yourself",
		client = {
			image = "id_card.png",
		}
	},

	["emerald_ring_silver"] = {
		label = "Emerald Ring Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "emerald_ring_silver.png",
		}
	},

	["wet_gold_phone"] = {
		label = "Wet Gold Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Did you really think that swimming in the ocean with your phone was a good idea?",
		client = {
			image = "wet_gold_phone.png",
		}
	},

	["thermite"] = {
		label = "Thermite",
		weight = 1000,
		stack = true,
		close = true,
		description = "Sometimes you'd wish for everything to burn",
		client = {
			image = "thermite.png",
		}
	},

	["burgershot_curly"] = {
		label = "Curly",
		weight = 100,
		stack = false,
		close = true,
		description = "Curly",
		client = {
			image = "burgershot_curly.png",
		}
	},

	["externals"] = {
		label = "Exterior Cosmetics",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "mirror.png",
		}
	},

	["weed_brick"] = {
		label = "Weed Brick",
		weight = 1000,
		stack = true,
		close = true,
		description = "1KG Weed Brick to sell to large customers.",
		client = {
			image = "weed_brick.png",
		}
	},

	["limeysgum"] = {
		label = "Trident Gum",
		weight = 100,
		stack = true,
		close = true,
		description = "Chewy! Minty! Fresh!",
		client = {
			image = "limeysgum.png",
		}
	},

	["grapejuice"] = {
		label = "Grape Juice",
		weight = 200,
		stack = true,
		close = false,
		description = "Grape juice is said to be healthy",
		client = {
			image = "grapejuice.png",
		}
	},

	["gold_phone"] = {
		label = "Gold Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "They say that Quasar Smartphone is the same as an iPhone, what do you think?",
		client = {
			image = "gold_phone.png",
		}
	},

	["silver_ring"] = {
		label = "Silver Ring",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "silver_ring.png",
		}
	},

	["ruby_ring_silver"] = {
		label = "Ruby Ring Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ruby_ring_silver.png",
		}
	},

	["ruby_earring_silver"] = {
		label = "Ruby Earrings Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ruby_earring_silver.png",
		}
	},

	["ironoxide"] = {
		label = "Iron Powder",
		weight = 100,
		stack = true,
		close = false,
		description = "Some powder to mix with.",
		client = {
			image = "ironoxide.png",
		}
	},

	["sapphire_earring"] = {
		label = "Sapphire Earrings",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sapphire_earring.png",
		}
	},

	["filled_evidence_bag"] = {
		label = "Evidence Bag",
		weight = 200,
		stack = false,
		close = false,
		description = "A filled evidence bag to see who committed the crime >:(",
		client = {
			image = "evidence.png",
		}
	},

	["cafe-uwu"] = {
		label = "Café",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cafe.png",
		}
	},

	["forceps"] = {
		label = "Forceps",
		weight = 500,
		stack = true,
		close = true,
		description = "edit here",
		client = {
			image = "forceps.png",
		}
	},

	["diving_gear"] = {
		label = "Diving Gear",
		weight = 30000,
		stack = false,
		close = true,
		description = "An oxygen tank and a rebreather",
		client = {
			image = "diving_gear.png",
		}
	},

	["certificate"] = {
		label = "Certificate",
		weight = 0,
		stack = true,
		close = true,
		description = "Certificate that proves you own certain stuff",
		client = {
			image = "certificate.png",
		}
	},

	["precision_muzzle_brake"] = {
		label = "Precision Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brake for a weapon",
		client = {
			image = "precision_muzzle_brake.png",
		}
	},

	["uncut_sapphire"] = {
		label = "Uncut Sapphire",
		weight = 100,
		stack = true,
		close = false,
		description = "A rough Sapphire",
		client = {
			image = "uncut_sapphire.png",
		}
	},

	["extrato-baunilha"] = {
		label = "Vanilla Extract",
		weight = 1500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "baunilha.png",
		}
	},

	["geocamo_attachment"] = {
		label = "Geometric Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A geometric camo for a weapon",
		client = {
			image = "geocamo_attachment.png",
		}
	},

	["car_wheel"] = {
		label = "Car Wheel",
		weight = 10000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "car_wheel.png",
		}
	},

	["diving_fill"] = {
		label = "Diving Tube",
		weight = 3000,
		stack = false,
		close = true,
		client = {
			image = "diving_tube.png",
		}
	},

	["jeans"] = {
		label = "Jeans",
		weight = 0,
		stack = false,
		close = true,
		description = "Jeans",
		client = {
			image = "jeans.png",
		}
	},

	["pinger"] = {
		label = "Pinger",
		weight = 1000,
		stack = true,
		close = true,
		description = "With a pinger and your phone you can send out your location",
		client = {
			image = "pinger.png",
		}
	},

	["tosti"] = {
		label = "Grilled Cheese Sandwich",
		weight = 200,
		stack = true,
		close = true,
		description = "Nice to eat",
		client = {
			image = "tosti.png",
		}
	},

	["glasses"] = {
		label = "Glasses",
		weight = 0,
		stack = false,
		close = true,
		description = "Glasses",
		client = {
			image = "glasses.png",
		}
	},

	["turbo"] = {
		label = "Supercharger Turbo",
		weight = 0,
		stack = false,
		close = true,
		description = "Who doesn't need a 65mm Turbo??",
		client = {
			image = "turbo.png",
		}
	},

	["mechboard"] = {
		label = "Mechanic Sheet",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "mechboard.png",
		}
	},

	["ruby"] = {
		label = "Ruby",
		weight = 100,
		stack = true,
		close = false,
		description = "A Ruby that shimmers",
		client = {
			image = "ruby.png",
		}
	},

	["lemon"] = {
		label = "Lemon",
		weight = 1000,
		stack = true,
		close = true,
		description = "an ingredient!",
		client = {
			image = "lemon.png",
		}
	},

	["grip_attachment"] = {
		label = "Grip",
		weight = 1000,
		stack = true,
		close = true,
		description = "A grip for a weapon",
		client = {
			image = "grip_attachment.png",
		}
	},

	["burgershot_frozennuggets"] = {
		label = "Frozen Nuggets",
		weight = 100,
		stack = false,
		close = true,
		description = "Frozen Nuggets",
		client = {
			image = "burgershot_frozennuggets.png",
		}
	},

	["syringe"] = {
		label = "Syringe",
		weight = 500,
		stack = true,
		close = true,
		description = "edit here",
		client = {
			image = "syringe.png",
		}
	},

	["tomato"] = {
		label = "Tomato",
		weight = 350,
		stack = true,
		close = true,
		description = "To-ma-to",
		client = {
			image = "tomato.png",
		}
	},

	["moneybag"] = {
		label = "Money Bag",
		weight = 0,
		stack = false,
		close = true,
		description = "A bag with cash",
		client = {
			image = "moneybag.png",
		}
	},

	["beer"] = {
		label = "Beer",
		weight = 500,
		stack = true,
		close = true,
		description = "Nothing like a good cold beer!",
		client = {
			image = "beer.png",
		}
	},

	["crack_baggy"] = {
		label = "Bag of Crack",
		weight = 0,
		stack = true,
		close = true,
		description = "To get happy faster",
		client = {
			image = "crack_baggy.png",
		}
	},

	["dirty_cabbage"] = {
		label = "Dirty Cabbage",
		weight = 350,
		stack = true,
		close = true,
		description = "Let-tuce? No!",
		client = {
			image = "dirty_cabbage.png",
		}
	},

	["horn"] = {
		label = "Custom Vehicle Horn",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "horn.png",
		}
	},

	["transmission4"] = {
		label = "Tier 4 Transmission",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "transmission4.png",
		}
	},

	["weedbud"] = {
		label = "Weed Bud",
		weight = 200,
		stack = true,
		close = false,
		description = "A small 2g weed bud..",
		client = {
			image = "weedbud.png",
		}
	},

	["fingerprintreader"] = {
		label = "Pro Tech XFR8001",
		weight = 200,
		stack = false,
		close = true,
		description = "A Pro Tech mobile fingerprint reader that looks like it's seen better days, currently stuck in french.",
		client = {
			image = "fingerprintreader.png",
		}
	},

	["burgershot_thesmurfsicecream"] = {
		label = "The Smurfs Ice Cream",
		weight = 100,
		stack = false,
		close = true,
		description = "The Smurfs Ice Cream",
		client = {
			image = "burgershot_thesmurfsicecream.png",
		}
	},

	["ifaks"] = {
		label = "ifaks",
		weight = 200,
		stack = true,
		close = true,
		description = "ifaks for healing and a complete stress remover.",
		client = {
			image = "ifak.png",
		}
	},

	["handcuffs"] = {
		label = "Handcuffs",
		weight = 100,
		stack = true,
		close = true,
		description = "Comes in handy when people misbehave. Maybe it can be used for something else?",
		client = {
			image = "handcuffs.png",
		}
	},

	["10kgoldchain"] = {
		label = "10k Gold Chain",
		weight = 2000,
		stack = true,
		close = true,
		description = "10 carat golden chain",
		client = {
			image = "10kgoldchain.png",
		}
	},

	["lime"] = {
		label = "Lime",
		weight = 1000,
		stack = true,
		close = true,
		description = "an ingredient!",
		client = {
			image = "lime.png",
		}
	},

	["skirts"] = {
		label = "Vehicle Skirts",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "skirts.png",
		}
	},

	["notepad"] = {
		label = "Notepad",
		weight = 100,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "notepad.png",
		}
	},

	["wet_classic_phone"] = {
		label = "Wet Classic Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Did you really think that swimming in the ocean with your phone was a good idea?",
		client = {
			image = "wet_classic_phone.png",
		}
	},

	["newsbmic"] = {
		label = "Boom Microphone",
		weight = 100,
		stack = false,
		close = true,
		description = "A Useable BoomMic",
		client = {
			image = "newsbmic.png",
		}
	},

	["diamond_necklace"] = {
		label = "Diamond Necklace",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "diamond_necklace.png",
		}
	},

	["engine5"] = {
		label = "Tier 5 Engine",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "engine5.png",
		}
	},

	["weed_nutrition"] = {
		label = "Plant Fertilizer",
		weight = 2000,
		stack = true,
		close = true,
		description = "Plant nutrition",
		client = {
			image = "weed_nutrition.png",
		}
	},

	["cleaningkit"] = {
		label = "Cleaning Kit",
		weight = 250,
		stack = true,
		close = true,
		description = "A microfiber cloth with some soap will let your car sparkle again!",
		client = {
			image = "cleaningkit.png",
		}
	},

	["bubble-menta"] = {
		label = "Mint Bubble Team",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "btmenta.png",
		}
	},

	["leopardcamo_attachment"] = {
		label = "Leopard Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A leopard camo for a weapon",
		client = {
			image = "leopardcamo_attachment.png",
		}
	},

	["tape"] = {
		label = "Tape",
		weight = 500,
		stack = true,
		close = true,
		description = "edit here",
		client = {
			image = "tape.png",
		}
	},

	["transmission3"] = {
		label = "Tier 3 Transmission",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "transmission3.png",
		}
	},

	["burgershot_shotnuggets"] = {
		label = "Shot Nuggets",
		weight = 100,
		stack = false,
		close = true,
		description = "Shot Nuggets",
		client = {
			image = "burgershot_shotnuggets.png",
		}
	},

	["burgershot_matchaicecream"] = {
		label = "Matcha Ice Cream",
		weight = 100,
		stack = false,
		close = true,
		description = "Matcha Ice Cream",
		client = {
			image = "burgershot_matchaicecream.png",
		}
	},

	["lttomato"] = {
		label = "Tomato",
		weight = 10,
		stack = true,
		close = true,
		description = ".",
		client = {
			image = "lttomato.png",
		}
	},

	["smoothieor"] = {
		label = "Orange Smoothie",
		weight = 10,
		stack = true,
		close = true,
		description = "Orange Smoothie",
		client = {
			image = "smoothieor.png",
		}
	},

	["newscam"] = {
		label = "News Camera",
		weight = 100,
		stack = false,
		close = true,
		description = "A camera for the news",
		client = {
			image = "newscam.png",
		}
	},

	["casino_goldchip"] = {
		label = "Casino Chip",
		weight = 0,
		stack = true,
		close = false,
		description = "Diamond Casino Chip",
		client = {
			image = "casino_goldchip.png",
		}
	},

	["ducttape"] = {
		label = "Duct Tape",
		weight = 0,
		stack = false,
		close = true,
		description = "Good for quick fixes",
		client = {
			image = "bodyrepair.png",
		}
	},

	["maplesyrup"] = {
		label = "Maple Syrup",
		weight = 10,
		stack = true,
		close = true,
		description = "Maple Syrup.",
		client = {
			image = "maplesyrup.png",
		}
	},

	["snikkel_candy"] = {
		label = "Snikkel",
		weight = 100,
		stack = true,
		close = true,
		description = "Some delicious candy :O",
		client = {
			image = "snikkel_candy.png",
		}
	},

	["burgershot_coffeeemptyglass"] = {
		label = "Coffee Empty Glass",
		weight = 100,
		stack = false,
		close = true,
		description = "Coffee Empty Glass",
		client = {
			image = "burgershot_coffeeemptyglass.png",
		}
	},

	["tablet"] = {
		label = "Tablet",
		weight = 2000,
		stack = true,
		close = true,
		description = "Expensive tablet",
		client = {
			image = "tablet.png",
		}
	},

	["sdcard"] = {
		label = "SD Card",
		weight = 1000,
		stack = false,
		close = true,
		description = "People still use these??",
		client = {
			image = "sdcard.png",
		}
	},

	["coke_small_brick"] = {
		label = "Coke Package",
		weight = 350,
		stack = false,
		close = true,
		description = "Small package of cocaine, mostly used for deals and takes a lot of space",
		client = {
			image = "coke_small_brick.png",
		}
	},

	["painkillers"] = {
		label = "Painkillers",
		weight = 0,
		stack = true,
		close = true,
		description = "For pain you can't stand anymore, take this pill that'd make you feel great again",
		client = {
			image = "painkillers.png",
		}
	},

	["coffee_beans"] = {
		label = "Coffee Beans",
		weight = 350,
		stack = true,
		close = true,
		description = "Wakey wakey!",
		client = {
			image = "coffee_beans.png",
		}
	},

	["patriotcamo_attachment"] = {
		label = "Patriot Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A patriot camo for a weapon",
		client = {
			image = "patriotcamo_attachment.png",
		}
	},

	["firework4"] = {
		label = "Weeping Willow",
		weight = 1000,
		stack = true,
		close = true,
		description = "Fireworks",
		client = {
			image = "firework4.png",
		}
	},

	["idcard"] = {
		label = "ID Card",
		weight = 0,
		stack = false,
		close = false,
		description = "A card containing all your information to identify yourself",
		client = {
			image = "id_card.png",
		}
	},

	["cupcake-chocolate"] = {
		label = "Chocolate Cupcake",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cupchocolate.png",
		}
	},

	["muffin-chocolate"] = {
		label = "Chocolate Muffin",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "mufchocolate.png",
		}
	},

	["fishingloot"] = {
		label = "Metal Box",
		weight = 500,
		stack = true,
		close = true,
		description = "Seems to be a corroded from the salt water, Should be easy to open",
		client = {
			image = "fishingloot.png",
		}
	},

	["casino_member"] = {
		label = "Casino Membership",
		weight = 500,
		stack = false,
		close = false,
		description = "Diamond Casino Member Card",
		client = {
			image = "casino_member.png",
		}
	},

	["classic_phone"] = {
		label = "Classic Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "They say that Quasar Smartphone is the same as an iPhone, what do you think?",
		client = {
			image = "classic_phone.png",
		}
	},

	["firework1"] = {
		label = "2Brothers",
		weight = 1000,
		stack = true,
		close = true,
		description = "Fireworks",
		client = {
			image = "firework1.png",
		}
	},

	["gsrtestkit"] = {
		label = "GSR Field Test Kit",
		weight = 200,
		stack = true,
		close = true,
		description = "A field GSR test kit containing several test strips",
		client = {
			image = "gsrtestkit.png",
		}
	},

	["orangedrink"] = {
		label = "Orange Drink",
		weight = 1000,
		stack = true,
		close = true,
		description = "A fancy orange juice...",
		client = {
			image = "orangedrink.png",
		}
	},

	["vodka"] = {
		label = "Vodka",
		weight = 500,
		stack = true,
		close = true,
		description = "For all the thirsty out there",
		client = {
			image = "vodka.png",
		}
	},

	["skullcamo_attachment"] = {
		label = "Skull Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A skull camo for a weapon",
		client = {
			image = "skullcamo_attachment.png",
		}
	},

	["milkshake-morango"] = {
		label = "Strawberry Milkshake",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "msmorango.png",
		}
	},

	["goldpan"] = {
		label = "Gold Panning Tray",
		weight = 10,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "goldpan.png",
		}
	},

	["burgershot_toy2"] = {
		label = "Burger Shot Toy",
		weight = 100,
		stack = false,
		close = true,
		description = "Burger Shot Toy",
		client = {
			image = "burgershot_toy2.png",
		}
	},

	["fishicebox"] = {
		label = "Fishing Ice Chest",
		weight = 2500,
		stack = false,
		close = true,
		description = "Ice Box to store all of your fish",
		client = {
			image = "fishicebox.png",
		}
	},

	["samsungphone"] = {
		label = "Samsung S10",
		weight = 1000,
		stack = true,
		close = true,
		description = "Very expensive phone",
		client = {
			image = "samsungphone.png",
		}
	},

	["lawyerpass"] = {
		label = "Lawyer Pass",
		weight = 0,
		stack = false,
		close = false,
		description = "Pass exclusive to lawyers to show they can represent a suspect",
		client = {
			image = "lawyerpass.png",
		}
	},

	["pancakesmaple"] = {
		label = "Syrup Pancakes",
		weight = 10,
		stack = true,
		close = true,
		description = "Yum.",
		client = {
			image = "pancakesmaple.png",
		}
	},

	["waffle-nutela"] = {
		label = "Nutela Waffle",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "wnutela.png",
		}
	},

	["caixa-amoras"] = {
		label = "Box of Blackberries",
		weight = 1500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "amoras.png",
		}
	},

	["burgershot_cheddar"] = {
		label = "Cheddar",
		weight = 100,
		stack = false,
		close = true,
		description = "Cheddar",
		client = {
			image = "burgershot_cheddar.png",
		}
	},

	["bprooftires"] = {
		label = "Bulletproof Tires",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "bprooftires.png",
		}
	},

	["rfid_disruptor"] = {
		label = "RFID Disruptor",
		weight = 1000,
		stack = true,
		close = false,
		description = "A Disruptor used for ATM firewalls",
		client = {
			image = "rfid_disruptor.png",
		}
	},

	["digicamo_attachment"] = {
		label = "Digital Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A digital camo for a weapon",
		client = {
			image = "digicamo_attachment.png",
		}
	},

	["burgershot_patatos"] = {
		label = "Small Size Patato",
		weight = 100,
		stack = false,
		close = true,
		description = "Small Size Patato",
		client = {
			image = "burgershot_patatos.png",
		}
	},

	["toolbox"] = {
		label = "Toolbox",
		weight = 0,
		stack = false,
		close = true,
		description = "Needed for Performance part removal",
		client = {
			image = "toolbox.png",
		}
	},

	["bag"] = {
		label = "Bag",
		weight = 10,
		stack = true,
		close = true,
		description = "Bag.",
		client = {
			image = "bag.png",
		}
	},

	["wet_black_phone"] = {
		label = "Wet Black Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Did you really think that swimming in the ocean with your phone was a good idea?",
		client = {
			image = "wet_black_phone.png",
		}
	},

	["veh_interior"] = {
		label = "Interior",
		weight = 1000,
		stack = true,
		close = true,
		description = "Upgrade vehicle interior",
		client = {
			image = "veh_interior.png",
		}
	},

	["weed_ak47_seed"] = {
		label = "AK47 Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "A weed seed of AK47",
		client = {
			image = "weed_seed.png",
		}
	},

	["bltsandwich"] = {
		label = "BLT Sandwich",
		weight = 10,
		stack = true,
		close = true,
		description = ".",
		client = {
			image = "bltsandwich.png",
		}
	},

	["drillbit"] = {
		label = "Drill Bit",
		weight = 10,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "drillbit.png",
		}
	},

	["sealedpackage"] = {
		label = "Sealed Package",
		weight = 15000,
		stack = false,
		close = false,
		description = "A heavy water-sealed package",
		client = {
			image = "sealedpackage.png",
		}
	},

	["advscope_attachment"] = {
		label = "Advanced Scope",
		weight = 1000,
		stack = true,
		close = true,
		description = "An advanced scope for a weapon",
		client = {
			image = "advscope_attachment.png",
		}
	},

	["ruby_ring"] = {
		label = "Ruby Ring",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ruby_ring.png",
		}
	},

	["stone"] = {
		label = "Stone",
		weight = 2000,
		stack = true,
		close = false,
		description = "Stone woo",
		client = {
			image = "stone.png",
		}
	},

	["split_end_muzzle_brake"] = {
		label = "Split End Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brake for a weapon",
		client = {
			image = "split_end_muzzle_brake.png",
		}
	},

	["caixa-morangos"] = {
		label = "Strawberries Box",
		weight = 1500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "morangos.png",
		}
	},

	["suspension3"] = {
		label = "Tier 3 Suspension",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "suspension3.png",
		}
	},

	["burgershot_colab"] = {
		label = "Big Size Cola",
		weight = 100,
		stack = false,
		close = true,
		description = "Big Size Cola",
		client = {
			image = "burgershot_colab.png",
		}
	},

	["bumper"] = {
		label = "Vehicle Bumper",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "bumper.png",
		}
	},

	["dolphin"] = {
		label = "Dolphin",
		weight = 5000,
		stack = false,
		close = false,
		description = "Dolphin",
		client = {
			image = "dolphin.png",
		}
	},

	["newsmic"] = {
		label = "News Microphone",
		weight = 100,
		stack = false,
		close = true,
		description = "A microphone for the news",
		client = {
			image = "newsmic.png",
		}
	},

	["harness"] = {
		label = "Race Harness",
		weight = 1000,
		stack = false,
		close = true,
		description = "Racing Harness so no matter what you stay in the car",
		client = {
			image = "harness.png",
		}
	},

	["ltbacon"] = {
		label = "Bacon",
		weight = 10,
		stack = true,
		close = true,
		description = ".",
		client = {
			image = "ltbacon.png",
		}
	},

	["sapphire_necklace_silver"] = {
		label = "Sapphire Necklace Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sapphire_necklace_silver.png",
		}
	},

	["veh_tint"] = {
		label = "Tints",
		weight = 1000,
		stack = true,
		close = true,
		description = "Install vehicle tint",
		client = {
			image = "veh_tint.png",
		}
	},

	["extrato-menta"] = {
		label = "Mint Extract",
		weight = 1500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "menta.png",
		}
	},

	["mininglaser"] = {
		label = "Mining Laser",
		weight = 900,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "mininglaser.png",
		}
	},

	["teapotcoffee"] = {
		label = "Cup of Coffee",
		weight = 10,
		stack = true,
		close = true,
		description = ".",
		client = {
			image = "teapotcoffee.png",
		}
	},

	["water_bottle"] = {
		label = "Bottle of Water",
		weight = 500,
		stack = true,
		close = true,
		description = "For all the thirsty out there",
		client = {
			image = "water_bottle.png",
		}
	},

	["sharkhammer"] = {
		label = "Shark",
		weight = 5000,
		stack = false,
		close = false,
		description = "Hammerhead Shark",
		client = {
			image = "sharkhammer.png",
		}
	},

	["perseuscamo_attachment"] = {
		label = "Perseus Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A perseus camo for a weapon",
		client = {
			image = "perseuscamo_attachment.png",
		}
	},

	["applecocktail"] = {
		label = "Apple Cocktail",
		weight = 1000,
		stack = true,
		close = true,
		description = "Rumor has it that Issac Newton made this.",
		client = {
			image = "applecocktail.png",
		}
	},

	["exhaust"] = {
		label = "Vehicle Exhaust",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "exhaust.png",
		}
	},

	["ltbox"] = {
		label = "LT Ingredients",
		weight = 10,
		stack = false,
		close = true,
		description = ".",
		client = {
			image = "ltbox.png",
		}
	},

	["iphone"] = {
		label = "iPhone",
		weight = 1000,
		stack = true,
		close = true,
		description = "Very expensive phone",
		client = {
			image = "iphone.png",
		}
	},

	["dirty_orange"] = {
		label = "Dirty Orange",
		weight = 350,
		stack = true,
		close = true,
		description = "The talking orange!",
		client = {
			image = "dirty_orange.png",
		}
	},

	["smoothiema"] = {
		label = "Mango Smoothie",
		weight = 10,
		stack = true,
		close = true,
		description = "Mango Smoothie",
		client = {
			image = "smoothiema.png",
		}
	},

	["apple"] = {
		label = "Apple",
		weight = 1000,
		stack = true,
		close = true,
		description = "an ingredient!",
		client = {
			image = "apple.png",
		}
	},

	["bass"] = {
		label = "Bass",
		weight = 1250,
		stack = false,
		close = false,
		description = "A normal fish Tatses pretty good!",
		client = {
			image = "bass.png",
		}
	},

	["weed_skunk_seed"] = {
		label = "Skunk Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "A weed seed of Skunk",
		client = {
			image = "weed_seed.png",
		}
	},

	["stingray"] = {
		label = "Stingray",
		weight = 2500,
		stack = false,
		close = false,
		description = "Stingray",
		client = {
			image = "stingray.png",
		}
	},

	["veh_wheels"] = {
		label = "Wheels",
		weight = 1000,
		stack = true,
		close = true,
		description = "Upgrade vehicle wheels",
		client = {
			image = "veh_wheels.png",
		}
	},

	["stickynote"] = {
		label = "Sticky note",
		weight = 0,
		stack = false,
		close = false,
		description = "Sometimes handy to remember something :)",
		client = {
			image = "stickynote.png",
		}
	},

	["heist_papers"] = {
		label = "Vehicle Papers",
		weight = 0,
		stack = false,
		close = true,
		description = "Delivery documents.",
		client = {
			image = "heist_papers.png",
		}
	},

	["clip_attachment"] = {
		label = "Clip",
		weight = 1000,
		stack = true,
		close = true,
		description = "A clip for a weapon",
		client = {
			image = "clip_attachment.png",
		}
	},

	["empty_evidence_bag"] = {
		label = "Empty Evidence Bag",
		weight = 0,
		stack = true,
		close = false,
		description = "Used a lot to keep DNA from blood, bullet shells and more",
		client = {
			image = "evidence_empty.png",
		}
	},

	["car_door"] = {
		label = "Car Door",
		weight = 10000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "car_door.png",
		}
	},

	["suspension2"] = {
		label = "Tier 2 Suspension",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "suspension2.png",
		}
	},

	["advancedrepairkit"] = {
		label = "Advanced Repairkit",
		weight = 4000,
		stack = true,
		close = true,
		description = "A nice toolbox with stuff to repair your vehicle",
		client = {
			image = "advancedkit.png",
		}
	},

	["bkr_prop_prtmachine_dryer_spin"] = {
		label = "Dryer Machine",
		weight = 500,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "bkr_prop_prtmachine_dryer_spin.png",
		}
	},

	["emerald_necklace"] = {
		label = "Emerald Necklace",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "emerald_necklace.png",
		}
	},

	["diamond_earring"] = {
		label = "Diamond Earrings",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "diamond_earring.png",
		}
	},

	["carbattery"] = {
		label = "Car Battery",
		weight = 0,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "carbattery.png",
		}
	},

	["weed_ak47"] = {
		label = "AK47 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "A weed bag with 2g AK47",
		client = {
			image = "weed_baggy.png",
		}
	},

	["veh_engine"] = {
		label = "Engine",
		weight = 1000,
		stack = true,
		close = true,
		description = "Upgrade vehicle engine",
		client = {
			image = "veh_engine.png",
		}
	},

	["sapphire_earring_silver"] = {
		label = "Sapphire Earrings Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sapphire_earring_silver.png",
		}
	},

	["sapphire"] = {
		label = "Sapphire",
		weight = 100,
		stack = true,
		close = false,
		description = "A Sapphire that shimmers",
		client = {
			image = "sapphire.png",
		}
	},

	["printerdocument"] = {
		label = "Document",
		weight = 500,
		stack = false,
		close = true,
		description = "A nice document",
		client = {
			image = "printerdocument.png",
		}
	},

	["bandageg"] = {
		label = "Bandage",
		weight = 500,
		stack = true,
		close = true,
		description = "edit here",
		client = {
			image = "bandageg.png",
		}
	},

	["zebracamo_attachment"] = {
		label = "Zebra Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A zebra camo for a weapon",
		client = {
			image = "zebracamo_attachment.png",
		}
	},

	["jerrycan"] = {
		label = "Jerry Can",
		weight = 15000,
		stack = false,
		close = false,
		description = "A Jerry Can made to hold gasoline.",
		client = {
			image = "jerrycan.png",
		}
	},

	["steel"] = {
		label = "Steel",
		weight = 100,
		stack = true,
		close = false,
		description = "Nice piece of metal that you can probably use for something",
		client = {
			image = "steel.png",
		}
	},

	["killerwhale"] = {
		label = "Whale",
		weight = 15000,
		stack = false,
		close = false,
		description = "Killer Whale",
		client = {
			image = "killerwhale.png",
		}
	},

	["mechanic_tools"] = {
		label = "Mechanic tools",
		weight = 0,
		stack = false,
		close = true,
		description = "Needed for vehicle repairs",
		client = {
			image = "mechanic_tools.png",
		}
	},

	["black_phone"] = {
		label = "Black Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "They say that Quasar Smartphone is the same as an iPhone, what do you think?",
		client = {
			image = "black_phone.png",
		}
	},

	["joint"] = {
		label = "Joint",
		weight = 0,
		stack = true,
		close = true,
		description = "Sidney would be very proud at you",
		client = {
			image = "joint.png",
		}
	},

	["paintingg"] = {
		label = "Painting G",
		weight = 120,
		stack = true,
		close = true,
		description = "Painting G",
		client = {
			image = "paintingg.png",
		}
	},

	["sandwich"] = {
		label = "Sandwich",
		weight = 200,
		stack = true,
		close = true,
		description = "Nice bread for your stomach",
		client = {
			image = "sandwich.png",
		}
	},

	["flashlight_attachment"] = {
		label = "Flashlight",
		weight = 1000,
		stack = true,
		close = true,
		description = "A flashlight for a weapon",
		client = {
			image = "flashlight_attachment.png",
		}
	},

	["diamond_ring_silver"] = {
		label = "Diamond Ring Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "diamond_ring_silver.png",
		}
	},

	["advancedlockpick"] = {
		label = "Advanced Lockpick",
		weight = 500,
		stack = true,
		close = true,
		description = "If you lose your keys a lot this is very useful... Also useful to open your beers",
		client = {
			image = "advancedlockpick.png",
		}
	},

	["luxuryfinish_attachment"] = {
		label = "Luxury Finish",
		weight = 1000,
		stack = true,
		close = true,
		description = "A luxury finish for a weapon",
		client = {
			image = "luxuryfinish_attachment.png",
		}
	},

	["cryptostick"] = {
		label = "Crypto Stick",
		weight = 200,
		stack = false,
		close = true,
		description = "Why would someone ever buy money that doesn't exist.. How many would it contain..?",
		client = {
			image = "cryptostick.png",
		}
	},

	["silverearring"] = {
		label = "Silver Earrings",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "silver_earring.png",
		}
	},

	["iodine"] = {
		label = "Iodine",
		weight = 500,
		stack = true,
		close = true,
		description = "edit here",
		client = {
			image = "iodine.png",
		}
	},

	["woodcamo_attachment"] = {
		label = "Woodland Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A woodland camo for a weapon",
		client = {
			image = "woodcamo_attachment.png",
		}
	},

	["dnatestkit"] = {
		label = "DNA Field Swab Kit",
		weight = 200,
		stack = true,
		close = true,
		description = "A field DNA swab kit containing several vials and swabs",
		client = {
			image = "dnatestkit.png",
		}
	},

	["cabbage"] = {
		label = "Cabbage",
		weight = 350,
		stack = true,
		close = true,
		description = "Let-tuce? No!",
		client = {
			image = "cabbage.png",
		}
	},

	["drugtestkit"] = {
		label = "Drug Test Kit",
		weight = 200,
		stack = true,
		close = true,
		description = "A multipanel field test kit used to test for popular drugs in a suspects saliva, it's probably accurate.",
		client = {
			image = "drugtestkit.png",
		}
	},

	["burgershot_coffee"] = {
		label = "Burger Shot Coffee",
		weight = 100,
		stack = false,
		close = true,
		description = "Burger Shot Coffee",
		client = {
			image = "burgershot_coffee.png",
		}
	},

	["ltteabags"] = {
		label = "Tea Bags",
		weight = 10,
		stack = true,
		close = true,
		description = ".",
		client = {
			image = "ltteabags.png",
		}
	},

	["suppressor_attachment"] = {
		label = "Suppressor",
		weight = 1000,
		stack = true,
		close = true,
		description = "A suppressor for a weapon",
		client = {
			image = "suppressor_attachment.png",
		}
	},

	["firework2"] = {
		label = "Poppelers",
		weight = 1000,
		stack = true,
		close = true,
		description = "Fireworks",
		client = {
			image = "firework2.png",
		}
	},

	["burgershot_bigfrozenpotato"] = {
		label = "Big Size Frozen Potato",
		weight = 100,
		stack = false,
		close = true,
		description = "Big Size Frozen Potato",
		client = {
			image = "burgershot_bigfrozenpotato.png",
		}
	},

	["firework3"] = {
		label = "WipeOut",
		weight = 1000,
		stack = true,
		close = true,
		description = "Fireworks",
		client = {
			image = "firework3.png",
		}
	},

	["surgical_staple"] = {
		label = "Surgical staple",
		weight = 500,
		stack = true,
		close = true,
		description = "edit here",
		client = {
			image = "surgical_staple.png",
		}
	},

	["plastic"] = {
		label = "Plastic",
		weight = 100,
		stack = true,
		close = false,
		description = "RECYCLE! - Greta Thunberg 2019",
		client = {
			image = "plastic.png",
		}
	},

	["suspension5"] = {
		label = "Tier 5 Suspension",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "suspension5.png",
		}
	},

	["burgershot_patatob"] = {
		label = "Big Size Patato",
		weight = 100,
		stack = false,
		close = true,
		description = "Big Size Patato",
		client = {
			image = "burgershot_patatob.png",
		}
	},

	["brushcamo_attachment"] = {
		label = "Brushstroke Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A brushstroke camo for a weapon",
		client = {
			image = "brushcamo_attachment.png",
		}
	},

	["burgershot_goatwrap"] = {
		label = "Goat Wrap",
		weight = 100,
		stack = false,
		close = true,
		description = "Goat Wrap",
		client = {
			image = "burgershot_goatwrap.png",
		}
	},

	["binoculars"] = {
		label = "Binoculars",
		weight = 600,
		stack = true,
		close = true,
		description = "Sneaky Breaky...",
		client = {
			image = "binoculars.png",
		}
	},

	["security_card_01"] = {
		label = "Security Card A",
		weight = 0,
		stack = true,
		close = true,
		description = "A security card... I wonder what it goes to",
		client = {
			image = "security_card_01.png",
		}
	},

	["burgershot_bigemptyglass"] = {
		label = "Big Size Empty Glass",
		weight = 100,
		stack = false,
		close = true,
		description = "Big Size Empty Glass",
		client = {
			image = "burgershot_bigemptyglass.png",
		}
	},

	["phone_module"] = {
		label = "Phone Module",
		weight = 300,
		stack = false,
		close = true,
		description = "It seems that we can fix a wet phone with this module, interesting.",
		client = {
			image = "phone_module.png",
		}
	},

	["drill"] = {
		label = "Drill",
		weight = 20000,
		stack = true,
		close = false,
		description = "The real deal...",
		client = {
			image = "drill.png",
		}
	},

	["nvscope_attachment"] = {
		label = "Night Vision Scope",
		weight = 1000,
		stack = true,
		close = true,
		description = "A night vision scope for a weapon",
		client = {
			image = "nvscope_attachment.png",
		}
	},

	["spoiler"] = {
		label = "Vehicle Spoiler",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "spoiler.png",
		}
	},

	["holoscope_attachment"] = {
		label = "Holo Scope",
		weight = 1000,
		stack = true,
		close = true,
		description = "A holo scope for a weapon",
		client = {
			image = "holoscope_attachment.png",
		}
	},

	["burgershot_bread"] = {
		label = "Bread",
		weight = 100,
		stack = false,
		close = true,
		description = "Bread",
		client = {
			image = "burgershot_bread.png",
		}
	},

	["customplate"] = {
		label = "Customized Plates",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "plate.png",
		}
	},

	["sessantacamo_attachment"] = {
		label = "Sessanta Nove Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A sessanta nove camo for a weapon",
		client = {
			image = "sessantacamo_attachment.png",
		}
	},

	["limeysdonut2"] = {
		label = "Chocolate Donut",
		weight = 200,
		stack = true,
		close = true,
		description = "Chocolate Donut!",
		client = {
			image = "limeysdonut2.png",
		}
	},

	["newoil"] = {
		label = "Car Oil",
		weight = 0,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "caroil.png",
		}
	},

	["uncut_diamond"] = {
		label = "Uncut Diamond",
		weight = 100,
		stack = true,
		close = false,
		description = "A rough Diamond",
		client = {
			image = "uncut_diamond.png",
		}
	},

	["ironore"] = {
		label = "Iron Ore",
		weight = 1000,
		stack = true,
		close = false,
		description = "Iron, a base ore.",
		client = {
			image = "ironore.png",
		}
	},

	["heavyarmor"] = {
		label = "Heavy Armor",
		weight = 5000,
		stack = true,
		close = true,
		description = "Some protection won't hurt... right?",
		client = {
			image = "armor.png",
		}
	},

	["paintingf"] = {
		label = "Painting F",
		weight = 120,
		stack = true,
		close = true,
		description = "Painting F",
		client = {
			image = "paintingf.png",
		}
	},

	["panqueca-oreo"] = {
		label = "Oreo Pancake",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "paoreo.png",
		}
	},

	["teapotorange"] = {
		label = "Orange Juice",
		weight = 10,
		stack = true,
		close = true,
		description = ".",
		client = {
			image = "teapotorange.png",
		}
	},

	["smoothiera"] = {
		label = "Raspberry Smoothie",
		weight = 10,
		stack = true,
		close = true,
		description = "Raspberry Smoothie",
		client = {
			image = "smoothiera.png",
		}
	},

	["veh_armor"] = {
		label = "Armor",
		weight = 1000,
		stack = true,
		close = true,
		description = "Upgrade vehicle armor",
		client = {
			image = "veh_armor.png",
		}
	},

	["sharktiger"] = {
		label = "Shark",
		weight = 5000,
		stack = false,
		close = false,
		description = "Tigershark",
		client = {
			image = "sharktiger.png",
		}
	},

	["burgershot_bigking"] = {
		label = "Big King Burger",
		weight = 100,
		stack = false,
		close = true,
		description = "Big King",
		client = {
			image = "burgershot_bigking.png",
		}
	},

	["green_phone"] = {
		label = "Green Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "They say that Quasar Smartphone is the same as an iPhone, what do you think?",
		client = {
			image = "green_phone.png",
		}
	},

	["veh_turbo"] = {
		label = "Turbo",
		weight = 1000,
		stack = true,
		close = true,
		description = "Install vehicle turbo",
		client = {
			image = "veh_turbo.png",
		}
	},

	["weed_whitewidow"] = {
		label = "White Widow 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "A weed bag with 2g White Widow",
		client = {
			image = "weed_baggy.png",
		}
	},

	["sparetire"] = {
		label = "Spare Tire",
		weight = 0,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "sparetire.png",
		}
	},

	["burgershot_icecreamcone"] = {
		label = "Empty Cone",
		weight = 100,
		stack = false,
		close = true,
		description = "Cone",
		client = {
			image = "burgershot_icecreamcone.png",
		}
	},

	["wet_pink_phone"] = {
		label = "Wet Pink Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "They say that Quasar Smartphone is the same as an iPhone, what do you think?",
		client = {
			image = "wet_pink_phone.png",
		}
	},

	["xtcbaggy"] = {
		label = "Bag of XTC",
		weight = 0,
		stack = true,
		close = true,
		description = "Pop those pills baby",
		client = {
			image = "xtc_baggy.png",
		}
	},

	["engine4"] = {
		label = "Tier 4 Engine",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "engine4.png",
		}
	},

	["burgershot_toy4"] = {
		label = "Burger Shot Toy",
		weight = 100,
		stack = false,
		close = true,
		description = "Burger Shot Toy",
		client = {
			image = "burgershot_toy4.png",
		}
	},

	["brakes1"] = {
		label = "Tier 1 Brakes",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "brakes1.png",
		}
	},

	["transmission1"] = {
		label = "Tier 1 Transmission",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "transmission1.png",
		}
	},

	["pancakemix"] = {
		label = "Pancake Mix",
		weight = 10,
		stack = true,
		close = true,
		description = "Pancake mix.",
		client = {
			image = "pancakemix.png",
		}
	},

	["livery"] = {
		label = "Livery Roll",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "livery.png",
		}
	},

	["barra-chocolate"] = {
		label = "Chocolate Bar",
		weight = 1500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "chocolate.png",
		}
	},

	["veh_brakes"] = {
		label = "Brakes",
		weight = 1000,
		stack = true,
		close = true,
		description = "Upgrade vehicle brakes",
		client = {
			image = "veh_brakes.png",
		}
	},

	["vehicletrackerscanner"] = {
		label = "Vehicle Tracker Scanner",
		weight = 1000,
		stack = false,
		close = true,
		description = "Scans a vehicle for existence of GPS tracker.",
		client = {
			image = "vehicletrackerscanner.png",
		}
	},

	["brakes3"] = {
		label = "Tier 3 Brakes",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "brakes3.png",
		}
	},

	["walkstick"] = {
		label = "Walking Stick",
		weight = 1000,
		stack = true,
		close = true,
		description = "Walking stick for ya'll grannies out there.. HAHA",
		client = {
			image = "walkstick.png",
		}
	},

	["cutter"] = {
		label = "Cutter",
		weight = 15000,
		stack = true,
		close = true,
		description = "Cutter.",
		client = {
			image = "trimming_scissors.png",
		}
	},

	["copper"] = {
		label = "Copper",
		weight = 100,
		stack = true,
		close = false,
		description = "Nice piece of metal that you can probably use for something",
		client = {
			image = "copper.png",
		}
	},

	["wet_white_phone"] = {
		label = "Wet White Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "They say that Quasar Smartphone is the same as an iPhone, what do you think?",
		client = {
			image = "wet_white_phone.png",
		}
	},

	["suspension4"] = {
		label = "Tier 4 Suspension",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "suspension4.png",
		}
	},

	["burgershot_smallfrozenpotato"] = {
		label = "Small Size Frozen Potato",
		weight = 100,
		stack = false,
		close = true,
		description = "Small Size Frozen Potato",
		client = {
			image = "burgershot_smallfrozenpotato.png",
		}
	},

	["gauze"] = {
		label = "Gauze",
		weight = 500,
		stack = true,
		close = true,
		description = "edit here",
		client = {
			image = "gauze.png",
		}
	},

	["white_phone"] = {
		label = "White Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "They say that Quasar Smartphone is the same as an iPhone, what do you think?",
		client = {
			image = "white_phone.png",
		}
	},

	["ltraspberry"] = {
		label = "Raspberries",
		weight = 10,
		stack = true,
		close = true,
		description = "Raspberries",
		client = {
			image = "ltraspberry.png",
		}
	},

	["sapphire_necklace"] = {
		label = "Sapphire Necklace",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sapphire_necklace.png",
		}
	},

	["iron"] = {
		label = "Iron",
		weight = 100,
		stack = true,
		close = false,
		description = "Handy piece of metal that you can probably use for something",
		client = {
			image = "iron.png",
		}
	},

	["heavy_duty_muzzle_brake"] = {
		label = "HD Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brake for a weapon",
		client = {
			image = "heavy_duty_muzzle_brake.png",
		}
	},

	["limao"] = {
		label = "Lemon",
		weight = 1500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "limao.png",
		}
	},

	["rolls"] = {
		label = "Roll Of Small Notes",
		weight = 100,
		stack = true,
		close = false,
		description = "A roll of small notes..",
		client = {
			image = "cashroll.png",
		}
	},

	["ruby_necklace"] = {
		label = "Ruby Necklace",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ruby_necklace.png",
		}
	},

	["powerbank"] = {
		label = "Power Bank",
		weight = 150,
		stack = false,
		close = true,
		description = "Incredible portable charger!",
		client = {
			image = "powerbank.png",
		}
	},

	["pearlscard"] = {
		label = "Pearls Seafood",
		weight = 100,
		stack = true,
		close = true,
		description = "A special member of Pearl's Seafood Restaurant",
		client = {
			image = "pearlscard.png",
		}
	},

	["bar"] = {
		label = "News book",
		weight = 100,
		stack = true,
		close = true,
		description = "LOL",
		client = {
			image = "np_book.png",
		}
	},

	["lemondrink"] = {
		label = "Lemon Drink",
		weight = 1000,
		stack = true,
		close = true,
		description = "Rip-off Lemonade",
		client = {
			image = "lemondrink.png",
		}
	},

	["teapottea"] = {
		label = "Cup of Tea",
		weight = 10,
		stack = true,
		close = true,
		description = ".",
		client = {
			image = "teapottea.png",
		}
	},

	["glass"] = {
		label = "Glass",
		weight = 100,
		stack = true,
		close = false,
		description = "It is very fragile, watch out",
		client = {
			image = "glass.png",
		}
	},

	["kurkakola"] = {
		label = "Cola",
		weight = 500,
		stack = true,
		close = true,
		description = "For all the thirsty out there",
		client = {
			image = "cola.png",
		}
	},

	["limeysdonut"] = {
		label = "Strawberry Donut",
		weight = 200,
		stack = true,
		close = true,
		description = "Strawberry Donut!",
		client = {
			image = "limeysdonut2.png",
		}
	},

	["helmet"] = {
		label = "Helmet",
		weight = 0,
		stack = false,
		close = true,
		description = "Helmet",
		client = {
			image = "helmet.png",
		}
	},

	["drum_attachment"] = {
		label = "Drum",
		weight = 1000,
		stack = true,
		close = true,
		description = "A drum for a weapon",
		client = {
			image = "drum_attachment.png",
		}
	},

	["emerald_earring_silver"] = {
		label = "Emerald Earrings Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "emerald_earring_silver.png",
		}
	},

	["burgershot_bigcardboard"] = {
		label = "Big Size Cardboard",
		weight = 100,
		stack = false,
		close = true,
		description = "Big Size Cardboard",
		client = {
			image = "burgershot_bigcardboard.png",
		}
	},

	["goldingot"] = {
		label = "Gold Ingot",
		weight = 1000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "goldingot.png",
		}
	},

	["dirty_tomato"] = {
		label = "Dirty Tomato",
		weight = 350,
		stack = true,
		close = true,
		description = "To-ma-to",
		client = {
			image = "dirty_tomato.png",
		}
	},

	["silveringot"] = {
		label = "Silver Ingot",
		weight = 1000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "silveringot.png",
		}
	},

	["mask"] = {
		label = "Mask",
		weight = 0,
		stack = false,
		close = true,
		description = "Mask",
		client = {
			image = "mask.png",
		}
	},

	["tshirt"] = {
		label = "T-shirt",
		weight = 0,
		stack = false,
		close = true,
		description = "Tshirt",
		client = {
			image = "tshirt.png",
		}
	},

	["burgershot_baggoat"] = {
		label = "Goat Menu Package",
		weight = 100,
		stack = false,
		close = true,
		description = "1x Goat Wrap, 1x Big Size Cola, 1x Shot Nuggets, 1x Shot Rings",
		client = {
			image = "burgershot_baggoat.png",
		}
	},

	["inked_cash_bag"] = {
		label = "Gruppe 6 Inked Cash Bag",
		weight = 1000,
		stack = true,
		close = false,
		description = "Bag full of useless inked cash.",
		client = {
			image = "inked_cash_bag.png",
		}
	},

	["goldbar"] = {
		label = "Gold Bar",
		weight = 500,
		stack = true,
		close = true,
		description = "Looks pretty expensive to me",
		client = {
			image = "goldbar.png",
		}
	},

	["weed_skunk"] = {
		label = "Skunk 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "A weed bag with 2g Skunk",
		client = {
			image = "weed_baggy.png",
		}
	},

	["greenlight_phone"] = {
		label = "Green Light Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "They say that Quasar Smartphone is the same as an iPhone, what do you think?",
		client = {
			image = "greenlight_phone.png",
		}
	},

	["delivery_food"] = {
		label = "Delivery Food",
		weight = 300,
		stack = false,
		close = true,
		description = "Grab food!?",
		client = {
			image = "burgershot_bagbig.png",
		}
	},

	["rubber"] = {
		label = "Rubber",
		weight = 100,
		stack = true,
		close = false,
		description = "Rubber, I believe you can make your own rubber ducky with it :D",
		client = {
			image = "rubber.png",
		}
	},

	["dirty_coffee_beans"] = {
		label = "Dirty Coffee Beans",
		weight = 350,
		stack = true,
		close = true,
		description = "Wakey wakey!",
		client = {
			image = "dirty_coffee_beans.png",
		}
	},

	["goldearring"] = {
		label = "Golden Earrings",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "gold_earring.png",
		}
	},

	["gelado-baunilha"] = {
		label = "Vanilla Icecream",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "gemorango.png",
		}
	},

	["burgershot_bagbig"] = {
		label = "Big Size Package",
		weight = 100,
		stack = false,
		close = true,
		description = "1x Big King, 1x Big Size Cola, 1x Big Size Patato",
		client = {
			image = "burgershot_bagbig.png",
		}
	},

	["carbon"] = {
		label = "Carbon",
		weight = 1000,
		stack = true,
		close = false,
		description = "Carbon, a base ore.",
		client = {
			image = "carbon.png",
		}
	},

	["smoothiest"] = {
		label = "Strawberry Smoothie",
		weight = 10,
		stack = true,
		close = true,
		description = "Strawberry Smoothie",
		client = {
			image = "smoothiest.png",
		}
	},
}