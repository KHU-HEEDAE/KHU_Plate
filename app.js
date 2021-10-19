const express = require('express')
const morgan = require('morgan')
const app = express()

app.use(morgan('combined'))

app.get('/api/banner', function(req, res) {
    return res.json(
        [
            {
                id: 1,
                // category_id: 5,
                img_path: "assets/banner_images/food1.png",
                txt1: "당신에게 추천하는 고깃집!",
                txt2: "고기 맛집 보러 가기"
            },
            {
                id: 2,
                // category_id: 2,
                img_path: "assets/banner_images/food2.png",
                txt1: "당신에게 추천하는 스시집!",
                txt2: "스시 맛집 보러 가기"
            },
            {
                id: 3,
                // category_id: 4,
                img_path: "assets/banner_images/food3.png",
                txt1: "당신에게 추천하는 파스타집!",
                txt2: "파스타 맛집 보러 가기"
            },
            {
                id: 4,
                // category_id: 3,
                img_path: "assets/banner_images/food4.png",
                txt1: "당신에게 추천하는 중식집!",
                txt2: "중식 맛집 보러 가기"
            },
            {
                id: 5,
                // category_id: 1,
                img_path: "assets/banner_images/food5.png",
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
                address: '수원시 영통구 백반로',
                tel: '00000000000',
                review_count: 5,
                rate: 4.5,
                img_path: 'assets/banner_images/food5.png',
                reviews: [
                    {
                        id: 1,
                        username: '학식러',
                        rate: 5.0,
                        content: "백반 가성비 강자!\n가격만 좋은 게 아니라 맛있기까지 해요!\n경희대 근처 맛집으로 강추!",
                        img_path: "assets/banner_images/food5.png",
                        avatar_path: "assets/banner_images/food1.png"
                    },
                    {
                        id: 2,
                        username: '지나가던 희대인',
                        rate: 4.7,
                        content: null,
                        img_path: "assets/banner_images/food1.png",
                        avatar_path: "assets/banner_images/food2.png"
                    },
                    {
                        id: 3,
                        username: '통학시러',
                        rate: 4.1,
                        content: "맛있어요~",
                        img_path: null,
                        avatar_path: null
                    },
                    {
                        id: 4,
                        username: '희대굳',
                        rate: 4.5,
                        content: null,
                        img_path: null,
                        avatar_path: null
                    },
                    {
                        id: 5,
                        username: '대학원생은 미생',
                        rate: 4.2,
                        content: "오 맛있어요우",
                        img_path: null,
                        avatar_path: null
                    }
                ]
            },
            {
                id: 2,
                // category_id: 2,
                name: '영통 스시',
                address: '수원시 영통구 스시로',
                tel: '0000000000',
                review_count: 3,
                rate: 4.6,
                img_path: 'assets/banner_images/food2.png',
                reviews: [
                    {
                        id: 6,
                        username: '지나가던 희대인',
                        rate: 4.7,
                        content: null,
                        img_path: "assets/banner_images/food1.png",
                        avatar_path: "assets/banner_images/food2.png"
                    },
                    {
                        id: 7,
                        username: '통학시러',
                        rate: 4.1,
                        content: "맛있어요~",
                        img_path: null,
                        avatar_path: null
                    },
                    {
                        id: 8,
                        username: '학식러',
                        rate: 5.0,
                        content: "스시 가성비 강자!",
                        img_path: "assets/banner_images/food2.png",
                        avatar_path: "assets/banner_images/food1.png"
                    }
                ]
            },
            {
                id: 3,
                // category_id: 3,
                name: '영통 반점',
                address: null,
                tel: null,
                review_count: 1,
                rate: 4.6,
                img_path: null,
                reviews : [
                    {
                        id: 9,
                        username: '통학시러',
                        rate: 4.6,
                        content: "맛있어요~",
                        img_path: null,
                        avatar_path: null
                    }
                ]
            },
            {
                id: 4,
                // category_id: 4,
                name: '영통 파스타',
                address: '수원시 영통구 파스타로',
                tel: '0000000000',
                review_count: 0,
                rate: 0.0,
                img_path: 'assets/banner_images/food3.png',
                reviews: []
            },
            {
                id: 5,
                // category_id: 5,
                name: '영통 왕갈비',
                address: '수원시 영통구 갈비로',
                tel: '00000000000',
                review_count: 0,
                rate: 0.0,
                img_path: 'assets/banner_images/food1.png',
                reviews: []
            },
        ]
    )
})

app.get('/api/review/:food_id', function(req, res) {
    switch (req.params.food_id) {
        case '1':
            return res.json(
                [
                    {
                        id: 1,
                        username: '학식러',
                        rate: 5.0,
                        content: "백반 가성비 강자!\n가격만 좋은 게 아니라 맛있기까지 해요!\n경희대 근처 맛집으로 강추!",
                        img_path: "assets/banner_images/food5.png",
                        avatar_path: "assets/banner_images/food1.png"
                    },
                    {
                        id: 2,
                        username: '지나가던 희대인',
                        rate: 4.7,
                        content: null,
                        img_path: "assets/banner_images/food1.png",
                        avatar_path: "assets/banner_images/food2.png"
                    },
                    {
                        id: 3,
                        username: '통학시러',
                        rate: 4.1,
                        content: "맛있어요~",
                        img_path: null,
                        avatar_path: null
                    },
                    {
                        id: 4,
                        username: '희대굳',
                        rate: 4.5,
                        content: null,
                        img_path: null,
                        avatar_path: null
                    },
                    {
                        id: 5,
                        username: '대학원생은 미생',
                        rate: 4.2,
                        content: "오 맛있어요우",
                        img_path: null,
                        avatar_path: null
                    }
                ]
            )
        case '2':
            return res.json(
                [
                    {
                        id: 6,
                        username: '지나가던 희대인',
                        rate: 4.7,
                        content: null,
                        img_path: "assets/banner_images/food1.png",
                        avatar_path: "assets/banner_images/food2.png"
                    },
                    {
                        id: 7,
                        username: '통학시러',
                        rate: 4.1,
                        content: "맛있어요~",
                        img_path: null,
                        avatar_path: null
                    },
                    {
                        id: 8,
                        username: '학식러',
                        rate: 5.0,
                        content: "스시 가성비 강자!",
                        img_path: "assets/banner_images/food2.png",
                        avatar_path: "assets/banner_images/food1.png"
                    }
                ]
            )
        case '3':
            return res.json(
                [
                    {
                        id: 9,
                        username: '통학시러',
                        rate: 4.6,
                        content: "맛있어요~",
                        img_path: null,
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

app.listen(8080, function () {
    console.log('App running on port 8080')
})
// install node.js
// npm install express
// npm install morgan
// npm install nodemon
// nodemon app.js