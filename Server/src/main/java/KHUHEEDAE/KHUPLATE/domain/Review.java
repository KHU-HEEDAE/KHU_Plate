package KHUHEEDAE.KHUPLATE.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@NoArgsConstructor
@Getter
@Table(name="REVIEW")
public class Review {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="REVIEW_ID")
    private Long id;

    @Column(name="REVIEW_CONTENT")
    private String content;

    @Column(name="REVIEW_RATE",nullable = false)
    private int rate;

    @Column(name="REVIEW_OWNER",nullable = false)
    private String reviewer;

    @Column(name="REVIEW_DATE")
    @CreationTimestamp
    private LocalDateTime date;

    @ManyToOne
    @JoinColumn(name="FOOD_ID")
    private Food food;

    public void setFood(Food food){
        this.food=food;
        if(!food.getReviewList().contains(this)){
            food.getReviewList().add(this);
        }
    }
}
