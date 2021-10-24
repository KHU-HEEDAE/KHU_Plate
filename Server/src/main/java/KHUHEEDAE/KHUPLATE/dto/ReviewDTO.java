package KHUHEEDAE.KHUPLATE.dto;

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
    private int rate;

    public ReviewDTO(Review review){
        this.id=review.getId();
        this.content=review.getContent();
        this.reviewer=review.getReviewer();
        this.date=review.getDate();
        this.rate = review.getRate();
    }

    public Review toEntity(){
        return Review.builder()
                .content(content)
                .reviewer(reviewer)
                .rate(rate)
                .build();
    }


}
