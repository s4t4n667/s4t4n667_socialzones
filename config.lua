
return {

    debug = false,                      -- show zone boundary

    defaultPayPeriod = 10,               -- in minutes (fallback if not defined in a zone)
    defaultMoneyType = 'money',          -- 'money' or 'black_money' (fallback if not defined in a zone)
    
    payWhenDead = false,

    socialZones = {
        {
            name = 'BurgerShot',
            icon = 'burger', 
            iconColor = '#b17214e5',
            payAmount = 500,
            payPeriod = 0.1,              -- in minutes
            payNotify = true,           -- notify players they've been paid?
            moneyType = 'money',        -- 'money' or 'black_money'
            points = {
                vector2(-1198.18, -914.21),
                vector2(-1218.04, -890.05),
                vector2(-1177.1691, -863.11),
                vector2(-1157.49, -893.42),
                vector2(-1183.9269, -909.3953),
                vector2(-1185.7928, -906.3600),
            },
            minZ = 10.0,
            maxZ = 20.0,
        },
        {
            name = 'Legion Square Car Park',
            icon = 'warehouse',
            iconColor = '',
            payAmount = 110,
            payPeriod = 10,             -- in minutes
            payNotify = true,           -- notify players they've been paid?
            moneyType = 'money',        -- 'money' or 'black_money'
            points = {
                vector2(199.1045, -806.4117),
                vector2(243.4202, -822.5151),
                vector2(277.9434, -738.6096),
                vector2(222.0008, -717.9221),             
            },
            minZ = 25.00,
            maxZ = 40.0,
        },
    },

    notifications = {
        position = 'top',
        enterColor = '#51A231',
        leaveColor = '#8C2425',
    },

}
