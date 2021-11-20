package KHUHEEDAE.KHUPLATE.controller;

import KHUHEEDAE.KHUPLATE.domain.Review;
import KHUHEEDAE.KHUPLATE.dto.FoodDTO;
import KHUHEEDAE.KHUPLATE.dto.ReviewDTO;
import KHUHEEDAE.KHUPLATE.service.ReviewService;
import org.springframework.web.bind.annotation.*;

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
    @GetMapping("/review")
    public List<ReviewDTO> viewReviewList(){
        List<Review> reviews = reviewService.findAll();
        List<ReviewDTO> result = reviews.stream()
                .filter(review -> review!=null)
                .map(ReviewDTO::new)
                .collect(Collectors.toList());
        return result;
    }

    //리뷰 추가
    @PostMapping("/review")
    public String writeReview(@RequestBody ReviewDTO request){
        reviewService.write(request.toEntity(),request.getFoodId());
        return "리뷰 추가";
    }

    //리뷰 삭제
    @DeleteMapping("/review")
    public String deleteReview(@RequestParam("id") Long id){
        reviewService.delete(id);
        return "리뷰 삭제";
    }

    //리뷰 수정
    @PatchMapping("/review")
    public String updateReview(@RequestParam("id") Long id, @RequestBody ReviewDTO request){
        reviewService.update(request.getContent(),request.getRate(),id);
        return "리뷰 수정";
    }
}
