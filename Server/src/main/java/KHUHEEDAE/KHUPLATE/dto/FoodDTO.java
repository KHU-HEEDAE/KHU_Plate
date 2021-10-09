package KHUHEEDAE.KHUPLATE.dto;

import KHUHEEDAE.KHUPLATE.domain.Food;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class FoodDTO {
    private Long id;
    private String name;
    private int rate;
    private int reviewNum;

    public FoodDTO(Food food){
        this.id=food.getId();
        this.name =food.getName();
        this.rate=food.getRate();
        this.reviewNum=food.getReviewNum();
    }
}
