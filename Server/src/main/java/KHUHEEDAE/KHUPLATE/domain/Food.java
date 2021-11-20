package KHUHEEDAE.KHUPLATE.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;


@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name="FOOD")
public class Food {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="FOOD_ID")
    private Long id;

    @Column(name="FOOD_NAME", nullable = false)
    private String name;

    @Column(name="FOOD_ADDRESS", nullable = false)
    private String address;

    @Column(name="FOOD_TEL", nullable = false)
    private String tel;

    @Column(name="FOOD_RATE", nullable = false)
    private float rate;

    @Column(name="FOOD_REVIEW_NUM", nullable = false)
    private int reviewNum;

    @ManyToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name="CATEGORY_ID")
    private Category category;

    @OneToMany(mappedBy = "food")
    private List<Review> reviewList = new ArrayList<Review>();

    public void insertReview(Review review){
        rate = (this.rate*reviewNum+review.getRate())/(reviewNum+1);
        reviewNum++;
    }

    public void addReview(Review review){
        this.reviewList.add(review);
        insertReview(review);
        if(review.getFood()!=this){
            review.setFood(this);
        }
    }



}
