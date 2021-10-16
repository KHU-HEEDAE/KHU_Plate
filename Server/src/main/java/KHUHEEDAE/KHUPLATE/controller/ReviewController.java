package KHUHEEDAE.KHUPLATE.controller;

import KHUHEEDAE.KHUPLATE.domain.Review;
import KHUHEEDAE.KHUPLATE.dto.FoodDTO;
import KHUHEEDAE.KHUPLATE.dto.ReviewDTO;
import KHUHEEDAE.KHUPLATE.service.ReviewService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("api")
public class ReviewController {


    private final ReviewService reviewService;

    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    //모든 리뷰 조회
    @GetMapping("review")
    public List<ReviewDTO> viewReviewList(){
        List<Review> reviews = reviewService.findAll();
        List<ReviewDTO> result = reviews.stream()
                .filter(review -> review!=null)
                .map(ReviewDTO::new)
                .collect(Collectors.toList());
        return result;
    }

}
