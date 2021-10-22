const express = require('express')
const morgan = require('morgan')
const app = express()

app.use(morgan('combined'))
app.use(express.json())
app.use(express.urlencoded({ extended: true }))

app.get('/api/banner', function(req, res) {
    return res.json(
        [
            {
                id: 1,
                // category_id: 5,
                image: "assets/banner_images/food1.png",
                txt1: "당신에게 추천하는 고깃집!",
                txt2: "고기 맛집 보러 가기"
            },
            {
                id: 2,
                // category_id: 2,
                image: "assets/banner_images/food2.png",
                txt1: "당신에게 추천하는 스시집!",
                txt2: "스시 맛집 보러 가기"
            },
            {
                id: 3,
                // category_id: 4,
                image: "assets/banner_images/food3.png",
                txt1: "당신에게 추천하는 파스타집!",
                txt2: "파스타 맛집 보러 가기"
            },
            {
                id: 4,
                // category_id: 3,
                image: "assets/banner_images/food4.png",
                txt1: "당신에게 추천하는 중식집!",
                txt2: "중식 맛집 보러 가기"
            },
            {
                id: 5,
                // category_id: 1,
                image: "assets/banner_images/food5.png",
                txt1: "당신에게 추천하는 백반집!",
                txt2: "한식 맛집 보러 가기"
            },
        ]
    )
})
// 한식: 1, 일식: 2, 중식: 3, 양식: 4, 고기/구이: 5
app.get('/api/food', function(req, res) {
    return res.json(
        [
            {
                id: 1,
                // category_id: 1,
                name: '영통 백반',
                review_count: 5,
                rate: 4.5,
                image: 'assets/banner_images/food5.png'
            },
            {
                id: 2,
                // category_id: 2,
                name: '영통 스시',
                review_count: 3,
                rate: 4.6,
                image: 'assets/banner_images/food2.png'
            },
            {
                id: 3,
                // category_id: 3,
                name: '영통 반점',
                review_count: 1,
                rate: 4.6,
                image: null
            },
            {
                id: 4,
                // category_id: 4,
                name: '영통 파스타',
                review_count: 0,
                rate: 0.0,
                image: 'assets/banner_images/food3.png'
            },
            {
                id: 5,
                // category_id: 5,
                name: '영통 왕갈비',
                review_count: 0,
                rate: 0.0,
                image: 'assets/banner_images/food1.png'
            },
        ]
    )
})


app.get('/api/food/:food_id', function(req, res) {
    switch(req.params.food_id) {
        case '1':
            return res.json(
                {
                    id: 1,
                    // category_id: 1,
                    name: '영통 백반',
                    address: '수원시 영통구 백반로',
                    tel: '00000000000',
                    review_count: 5,
                    rate: 4.5,
                    image: 'assets/banner_images/food5.png',
                    review: [
                        {
                            id: 1,
                            writer: '학식러',
                            rate: 5.0,
                            content: "백반 가성비 강자!\n가격만 좋은 게 아니라 맛있기까지 해요!\n경희대 근처 맛집으로 강추!",
                            image: "assets/banner_images/food5.png",
                            avatar_path: "assets/banner_images/food1.png"
                        },
                        {
                            id: 2,
                            writer: '지나가던 희대인',
                            rate: 4.7,
                            content: null,
                            image: "assets/banner_images/food1.png",
                            avatar_path: "assets/banner_images/food2.png"
                        },
                        {
                            id: 3,
                            writer: '통학시러',
                            rate: 4.1,
                            content: "맛있어요~",
                            image: null,
                            avatar_path: null
                        },
                        {
                            id: 4,
                            writer: '희대굳',
                            rate: 4.5,
                            content: null,
                            image: null,
                            avatar_path: null
                        },
                        {
                            id: 5,
                            writer: '대학원생은 미생',
                            rate: 4.2,
                            content: "오 맛있어요우",
                            image: null,
                            avatar_path: null
                        }
                    ]
                }
            )
        case '2':
            return res.json(
                {
                    id: 2,
                    // category_id: 2,
                    name: '영통 스시',
                    address: '수원시 영통구 스시로',
                    tel: '0000000000',
                    review_count: 3,
                    rate: 4.6,
                    image: 'assets/banner_images/food2.png',
                    review: [
                        {
                            id: 6,
                            writer: '지나가던 희대인',
                            rate: 4.7,
                            content: null,
                            image: "assets/banner_images/food1.png",
                            avatar_path: "assets/banner_images/food2.png"
                        },
                        {
                            id: 7,
                            writer: '통학시러',
                            rate: 4.1,
                            content: "맛있어요~",
                            image: null,
                            avatar_path: null
                        },
                        {
                            id: 8,
                            writer: '학식러',
                            rate: 5.0,
                            content: "스시 가성비 강자!",
                            image: "assets/banner_images/food2.png",
                            avatar_path: "assets/banner_images/food1.png"
                        }
                    ]
                }
            )
        case '3':
            return res.json(
                {
                    id: 3,
                    // category_id: 3,
                    name: '영통 반점',
                    address: null,
                    tel: null,
                    review_count: 1,
                    rate: 4.6,
                    image: null,
                    review: [
                        {
                            id: 9,
                            writer: '통학시러',
                            rate: 4.6,
                            content: "맛있어요~",
                            image: null,
                            avatar_path: null
                        }
                    ]
                }
            )
        case '4':
            return res.json(
                {
                    id: 4,
                    // category_id: 4,
                    name: '영통 파스타',
                    address: '수원시 영통구 파스타로',
                    tel: '0000000000',
                    review_count: 0,
                    rate: 0.0,
                    image: 'assets/banner_images/food3.png',
                    review: []
                }
            )
        case '5':
            return res.json(
                {
                    id: 5,
                    // category_id: 5,
                    name: '영통 왕갈비',
                    address: '수원시 영통구 갈비로',
                    tel: '00000000000',
                    review_count: 0,
                    rate: 0.0,
                    image: 'assets/banner_images/food1.png',
                    review: []
                }
            )
    }
})

app.get('/api/review/:food_id', function(req, res) {
    switch (req.params.food_id) {
        case '1':
            return res.json(
                [
                    {
                        id: 1,
                        writer: '학식러',
                        rate: 5.0,
                        content: "백반 가성비 강자!\n가격만 좋은 게 아니라 맛있기까지 해요!\n경희대 근처 맛집으로 강추!",
                        image: "assets/banner_images/food5.png",
                        avatar_path: "assets/banner_images/food1.png"
                    },
                    {
                        id: 2,
                        writer: '지나가던 희대인',
                        rate: 4.7,
                        content: null,
                        image: "assets/banner_images/food1.png",
                        avatar_path: "assets/banner_images/food2.png"
                    },
                    {
                        id: 3,
                        writer: '통학시러',
                        rate: 4.1,
                        content: "맛있어요~",
                        image: null,
                        avatar_path: null
                    },
                    {
                        id: 4,
                        writer: '희대굳',
                        rate: 4.5,
                        content: null,
                        image: null,
                        avatar_path: null
                    },
                    {
                        id: 5,
                        writer: '대학원생은 미생',
                        rate: 4.2,
                        content: "오 맛있어요우",
                        image: null,
                        avatar_path: null
                    }
                ]
            )
        case '2':
            return res.json(
                [
                    {
                        id: 6,
                        writer: '지나가던 희대인',
                        rate: 4.7,
                        content: null,
                        image: "assets/banner_images/food1.png",
                        avatar_path: "assets/banner_images/food2.png"
                    },
                    {
                        id: 7,
                        writer: '통학시러',
                        rate: 4.1,
                        content: "맛있어요~",
                        image: null,
                        avatar_path: null
                    },
                    {
                        id: 8,
                        writer: '학식러',
                        rate: 5.0,
                        content: "스시 가성비 강자!",
                        image: "assets/banner_images/food2.png",
                        avatar_path: "assets/banner_images/food1.png"
                    }
                ]
            )
        case '3':
            return res.json(
                [
                    {
                        id: 9,
                        writer: '통학시러',
                        rate: 4.6,
                        content: "맛있어요~",
                        image: null,
                        avatar_path: null
                    }
                ]
            )
        case '4':
            return res.json([])
        case '5':
            return res.json([])
    }
})

app.post('/api/review/', function(req, res) {
    console.log(req.body)
    res.sendStatus(200)
})

app.listen(8080, function () {
    console.log('App running on port 8080')
})
// install node.js
// npm install express
// npm install morgan
// npm install nodemon
// nodemon app.js
