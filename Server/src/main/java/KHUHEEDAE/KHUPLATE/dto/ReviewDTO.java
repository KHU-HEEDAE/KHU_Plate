package KHUHEEDAE.KHUPLATE.dto;

import KHUHEEDAE.KHUPLATE.domain.Food;
import KHUHEEDAE.KHUPLATE.domain.Review;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
public class ReviewDTO {
    private Long id;
    private String content;
    private String reviewer;
    private LocalDateTime date;
    private float rate;
    private Long foodId;

    public ReviewDTO(Review review){
        this.id=review.getId();
        this.content=review.getContent();
        this.reviewer=review.getReviewer();
        this.date=review.getDate();
        this.rate = review.getRate();
        this.foodId=review.getFood().getId();
    }

    public Review toEntity(){
        Review review = new Review();
        review.setContent(this.content);
        review.setReviewer(this.reviewer);
        review.setDate(this.date);
        review.setRate(this.rate);
        return review;
    }


}
