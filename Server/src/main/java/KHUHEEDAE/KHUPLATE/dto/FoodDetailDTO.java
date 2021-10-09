package KHUHEEDAE.KHUPLATE.dto;

import KHUHEEDAE.KHUPLATE.domain.Food;
import KHUHEEDAE.KHUPLATE.domain.Review;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class FoodDetailDTO {
    private Long id;
    private String name;
    private int rate;
    private int reviewNum;
    private String address;
    private String tel;
    private List<ReviewDTO> reviewDTOList = new ArrayList<ReviewDTO>();

    //연관관계 메서드
    public void addReview(Review review){
        this.reviewDTOList.add(new ReviewDTO(review));
    }

    public FoodDetailDTO(Food food){
        this.id=food.getId();
        this.name=food.getName();
        this.rate=food.getRate();
        this.reviewNum=food.getReviewNum();
        this.address=food.getAddress();
        this.tel=food.getTel();
        for(Review review : food.getReviewList()){
            this.addReview(review);
        }

    }
}
